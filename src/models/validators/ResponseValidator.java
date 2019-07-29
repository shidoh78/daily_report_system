package models.validators;

import java.util.ArrayList;
import java.util.List;

import models.Response;

public class ResponseValidator {
    public static List<String> validate(Response r){
        List<String> errors = new ArrayList<String>();

        String title_error = _validateTitle(r.getTitle());
        if(!title_error.equals("")){
            errors.add(title_error);
        }

        String content_error = _validateContent(r.getContent());
        if(!content_error.equals("")){
            errors.add(content_error);
        }
        return errors;
    }

    private static String _validateTitle(String title){
        if(title == null || title.equals("")){
            return "タイトルを入力してください。";
        }
        return "";
    }

    private static String _validateContent(String content){
        if(content == null || content.equals("")){
            return "内容を入力してください。";
        }
        return "";
    }
}
