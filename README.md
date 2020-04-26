Simutrans server for Docker
====

## Overview - 概要
 Simutrans server in a Docker container.  
 Simutransサーバをコンテナ化してみました。  

## Quick start - 手っ取り早く起動 

```docker run -it -e SIMUTRANS_SERVERNAME=<Servername> -e SIMUTRANS_SAVEGAME=<Savefile> -v <savefilepath>:/opt/simutrans/save -d -p <port>:13353 simutrans:stable```

## What's New? - 更新履歴
 - 2020/04/26  
   Support new version (v121.0 r8870)  
   新しいバージョンに対応しました。(v121.0 r8870)  

## Description - 詳細
 In Dockerfile, download version 120.4.1(r8588) source, ./configure with server options ,compile simutrans with fix a bugs, download and unzip paksets....  
 so It was very looong road for me.;-)  
 Dockerfileの中では、120.4.1(r8588)のソースをダウンロードし、サーバーオプションと共にconfigureし、バグをつぶしつつコンパイルし、パックセットをダウンロードし・・・  
 それは私にとって、とてもながーい道のりでした。  

 And finally, I noticed.  
 そして、最後に気がついてしまったのです。  
 
 The revision number is different, with this(r8588) and my desktop machine(r8600).  
 デスクトップマシンとこのサーバとでリビジョン番号が違うことに。  

## Background - 背景
 2days ago,I wanted to play simutrans with my friends.  
 So, I desided to serve it with docker.  
 Because, I'm hosting some services with docker too.  
 ぶっちゃけて言うと友人とsimutransしたいがために作りました。  
 サーバ上でDockerを使った他のサービスも動作しているので、Dockerに揃えたいと思いました。  

## Featurework - 今後の展望
 - Creating world-data automatically.(It's difficult?)  
   ワールドの自動生成（とか、難しいかな）  
 - Support for various paksets.(Now only pak64.)  
   様々なパックセットへの対応（現在pak64のみ）  
