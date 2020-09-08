
class New {
   int id;
   String title;
   String description;
   String imagUrl;
   bool isLast;
   DateTime dataCriacao;
   Map json;


  New({Object arguments, this.title, this.description, this.imagUrl,this.dataCriacao,this.isLast,this.id});

  New.fromJson(this.json){
    title = json['titulo'];
    description = json['descricao'];
    imagUrl = json['imagemUrl'];
    if(json['dataCriacao'] != null){
    dataCriacao = DateTime.parse(json['dataCriacao']);
    }
    isLast =json["last"];
    id = json["id"];
  }


}
