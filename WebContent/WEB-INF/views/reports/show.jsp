<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${report != null}">
                <h2>日報　詳細ページ</h2>
                <p>
                    <a href="<c:url value='/reports/index'/>">一覧に戻る</a>&nbsp;
                    <c:if test="${sessionScope.login_employee.id == report.employee.id }">
                        <a href="<c:url value='/reports/edit?id=${report.id }'/>">この日報を編集する</a>
                    </c:if>
                </p>
                <table>
                    <tbody>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${report.employee.name }"/></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value='${report.report_date }' pattern='yyyy-MM-dd' /></td>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td>
                                <fmt:formatDate value="${report.created_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td>
                                <fmt:formatDate value="${report.updated_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </td>
                        </tr>
                        <tr>
                            <th>内容</th>
                            <td>
                                <pre><c:out value="${report.content }"/></pre>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br/>

                <table id="response_list">
                    <tbody>
                        <tr>
                            <th rowspan="2">返信 ${responses_count } 件</th>
                        </tr>
                        <c:forEach var="response" items="${responses }" varStatus="status">
                            <tr>
                                <th>氏名</th>
                                <td><c:out value="${response.employee.name }"/></td>
                            </tr>
                            <tr>
                                <th>日付</th>
                                <td><fmt:formatDate value='${response.report_date }' pattern='yyyy-MM-dd' /></td>
                            </tr>
                            <tr>
                                <th>登録日時</th>
                                <td>
                                    <fmt:formatDate value="${response.created_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </td>
                            </tr>
                            <tr>
                                <th>更新日時</th>
                                <td>
                                    <fmt:formatDate value="${response.updated_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </td>
                            </tr>
                            <tr>
                                <th>内容</th>
                                <td>
                                    <pre><c:out value="${response.content }"/></pre>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <br/>

                <form method="POST" action="<c:url value='/responses/create'/>">
                    <c:import url="../responses/_form.jsp"/>
                </form>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>
    </c:param>
</c:import>