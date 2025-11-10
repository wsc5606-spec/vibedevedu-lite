/// 모든 언어의 챌린지를 통합한 데이터

import 'python_challenges.dart';
import 'dart_challenges.dart';
import 'go_challenges.dart';
import 'java_challenges.dart';
import 'typescript_challenges.dart';
import 'javascript_challenges.dart';
// import 'sql_challenges.dart'; // TODO: Fix encoding
import 'c_challenges.dart';
import 'cpp_challenges.dart';
import 'csharp_challenges.dart';
import 'kotlin_challenges.dart';
import 'html_challenges.dart';
import 'css_challenges.dart';

class AllChallenges {
  static List<Map<String, dynamic>> getAllChallenges() {
    final challenges = <Map<String, dynamic>>[];

    challenges.addAll(PythonChallenges.getChallenges());
    challenges.addAll(DartChallenges.getChallenges());
    challenges.addAll(GoChallenges.getChallenges());
    challenges.addAll(JavaChallenges.getChallenges());
    challenges.addAll(TypescriptChallenges.getChallenges());
    challenges.addAll(JavascriptChallenges.getChallenges());
    // challenges.addAll(SqlChallenges.getChallenges()); // TODO: Fix SQL file encoding
    challenges.addAll(CChallenges.getChallenges());
    challenges.addAll(CppChallenges.getChallenges());
    challenges.addAll(CsharpChallenges.getChallenges());
    challenges.addAll(KotlinChallenges.getChallenges());
    challenges.addAll(HtmlChallenges.getChallenges());
    challenges.addAll(CssChallenges.getChallenges());

    print('📊 [DEBUG] Total challenges loaded: ${challenges.length}');

    return challenges;
  }
}
