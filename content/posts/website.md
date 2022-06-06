---
title: "Website"
date: 2022-06-06T14:31:34+02:00
tags: ['tech','linux','CI/CD','Webseite']
author: ['Robnarok']
draft: false
showtoc: true
---
## Technischer Aufbau meiner Website

### Into

Ahoy! Das hier ist jetzt mein erster richtiger Post hier auf dem Blog. Ich fang
direkt einfach mal damit an, wie ich den Blog hier aufgebaut habe, wie ich drauf
gekommen bin und welche Holzwege ich dabei genommen habe. Die Holzwege sind ja
schließlich das Spannendste!

Es fing alles dabei an, dass mir jemand von dem Konzept Static Side Generators
erzählt hat und ein paar Argumente gebracht hat, warum sowas ein viel cooles
Konzept ist als Wordpress und ähnliche alten PHP Monstrositäten. Ich war dann
ein bisschen gehypt und hab mir einfach mal ein Wochenende dafür Zeit genommen
ein klein wenig was zu basteln. Zwar hab ich inhaltlich kein Konzept, aber das
basteln war mal spannend. Vielleicht finde ich so ja ein bisschen in das Blog
schreiben rein.

Ich hab vorher nur mal am Rande von Jekyll gehört .. Und mit
gehört meine ich das ganze in dem Footer von irgendeinen Blog gelesen zu haben
und dann etwas weiter recherchiert habe und festgestellt habe, dass ich die Idee
Markdown Dokumente einfach in coole Webseiten zu verwandeln. Aber das ganze hatte
in dem Moment nur geschafft, dass ich ein Bookmark gesetzt habe und das ganze
dann irgendwann fast vergessen habe.

Also hab ich direkt am folgetag direkt mal nach Static Side Generators geschaut
und mich ein bisschen eingelesen. Und dabei bin ich noch über 1-2 Sachen
gestolpert.

### Was ist ein Static Side Generator

Bevor es noch weiter Unklar bleibt erklär ich mal ganz kurz, was ich mit Static
Side Generator überhaupt meine. So ein generator nimmt Markdown-Datein und
"kompiliert" die dann zu fertigen HTML Seiten. Damit man nicht mit blanken HTML
da steht, kann man auch Themes angeben.. Die Themes übernehmen dann zum einen
das Einbinden von CSS, aber auch noch ein paar andere Features. Der wechsel
zwischen Themes ist eigentlich recht simpel und meistens ist es nur ein
Config-File, was man dafür überarbeiten muss.

Also statt ein riesen großes Programm wie Wordpress oder sonstige CMS braucht
man für die SSGs nur einen ganz einfachen Webserver, der nur statischen Kontent
ausliefert... Der Aufwand dafür ist wirklich sehr gering.

Zumindest war das bei den Generatoren so, die ich mir angeschaut habe.

### Welchen Generator hab ich letzten Endes gewählt ?

Ich hab mich für [Hugo entschieden](https://gohugo.io/) ... [Dafür hab ich eine
Auflistung gefunden gehabt von allen großen SSGs](https://jamstack.org/generators/)
Ganz so genau hab ich mir nicht alle Möglichkeiten angeschaut... Ehrlich gesagt
hab ich die Auflistung nur überflogen und dann gesehen, dass Hugo in Go
geschrieben ist. Und weil ich ein großer Fan von Go bin, hab ich dann das
genommen. Auch bei der Theme Auswahl war ich dann etwas unkreativ. Dafür gibt es
auf der Hugo Seite eine [schöne Auflistung von Themes](https://themes.gohugo.io/)
Meine erste Entscheidung war PaperMod.. Das installieren davon war recht
einfach.. Aber ich war dann doch stark überfordert. Statt mit .toml als Config
hat das Theme im Beispiel dann .yaml benutzt.. Womit ich zwar mehr vertraut bin,
aber im ersten Blick waren dann durch 2 verschiedene Configs alles echt ein
bisschen komisch. Ich hab erst die Beispielconfig zu .toml umgeschrieben
gehabt.. Am Ende bin ich dann aber auf .yaml umgestiegen - und hab die "default"
Config genommen und etwas auseinandergenommen.. Irgenwie war ich dann aber doch
mit dem Ergebnis nicht so zufrieden - auch wenn die Seite echt super aussah und
ein paar echt coole Features drin hatte:
- RSS Feat Link bei den Kategorien,
- Es gab eine Suche, die man einbauen konnte
- Vermutlich noch mehr, was ich jetzt gerade vergesse.
[Hier nochmal der Link zu dem Theme](https://themes.gohugo.io/themes/hugo-papermod/)

Mir war das für das erste aber zuviel. Ich bin dann nochmal durch die Themes
durchgescrollt und hab mir was "leichteres" gesucht. Am Ende wurde es dann
[m10c](https://themes.gohugo.io/themes/hugo-theme-m10c/)
Das war um einiges einfacher. Es gibt letzten Endes 5 Parameter, die man in den
Configs einsetzen kann - und bei bedarf kann man das Farb Theme noch abändern.
Das war dann nicht ganz so überfordernd wie PaperMod. Mir fehlen hier jetzt ein
paar Features, aber ich werde bestimmt nochmal wechseln. Für das erste ist das
denke ich ein besserer Einstieg (Wer braucht schon eine Suche, wenn man keinen
Content hat).

### CI/CD

#### Der Weg dahin

Um das ganze erstmal zu testen, habe ich auf meinem Server das ganze ohne Git
oder sonstiges ausprobiert.. Ich hab dann einfach meinen Webserver auf das
Output Directory zeigen lassen - und tada! Meine Website war fertig und
erreichbar. Aber das sollte so noch nicht reichen. Jeden Artikel per Hand auf
dem Server dann zu schrieben ist im Prinzip machbar, aber noch nicht perfekt.

#### Github

Also hab ich ein Github Repo für meine Seite erstellt und da den kompletten
Kontent reingehauen. Sprich für das Deployen konnte ich dann lokal editieren.
Und einfach per `git pull` den Content aktualisieren.. Aber sowas ist dann
natürlich mehraufwand. 

#### Github Actions - der Selfhosted Runner

Kurzer Disclaimer: ich hab mich noch nicht so viel mit den Github Actions
auseinander gesetzt, dass ich behaupten würde ich wäre gut darin. Ich hab da
viel nachgeschaut.. und Github hat auch sehr viele vorgebaute Actions, was es
leicht macht sich inspirieren zu lassen, wie alles funktioniert.

Ich wollte das Deployen damit erledigen. Da hab ich aber nichts so perfektes
gefunden. Irgendwas in der Cloud via AWS, Google oder was auch immer zu deployen
scheint sehr weit verbreitet. Ich hab aber meinen VPS. Also brauchte ich da eine
gute Lösung, wie ich mein System so möglichst wenig gefährde, wenn ich was
implementiere.. Und da kam ich auf einen Self Hosted Runner... Ich hab auf
meinem Server einfach selbst einen Runner aufgesetzt. Um das noch weiter
abzusichern via Docker. [Dafür gibt es hier ein Repo](https://github.com/tcardonne/docker-github-runner)
und jede menge Artikel, die noch mehr Kontext dazu geben.
Das Docker-Compose File hab ich dann einfach übernommen - aber noch ein
zusätzliches Volume eingebunden. Und zwar das komplette `_work` Dir hab ich als
Volume gemountet. So konnte ich dann innerhalb des Runners die Website jedes mal
bauen.. Das ist übrigens echt leicht bei Hugo mit einen `hugo -D`. Und meinen
Webserver hab ich dann auf das Verzeichnis zeigen lassen.
Das hat auch gut funktioniert. War echt schnell und eigentlich doch recht
gescheit, denke ich.

Das ganze hab ich aber dann doch angezündet. Das Konstrukt hat mir nicht so gut
gefallen, aber es war mal spannend zu basteln. Ich bin für Vorschläge offen, ob
das so vielleicht doch eine okayishe Practice war.

#### Github Cloud Runner + ssh

Das was ich jetzt am Ende habe ist ein Workflow, der einfach einen Cloud Runner
verwendet und dann via ssh auf meinen Server erst aufräumt, dann neu deployed.
Dafür hab ich natürlich einen extra User erstellt und die Credencials als
Repository Secrete hinzugefügt.. Und hoffe, dass das so wirklich secure ist. Ich
bin der einzige Contributer im Repo und sonst darf auch niemand was machen. Die
Action triggert nur, wenn etwas im Main gepushed wird... Vielleicht fällt mir
irgendwann was besseres ein. Aber damit komme ich besser klar, als mit dem
eigenen Runner.

Hier ist übrigens das aktuelle Workflow.yaml aus Github. Ich nehm Kritik immer
gerne an (Falls den Blog hier wirklich jemals jemand liest)

``` yaml
name: CI
on:
  push:
    branches:
      - main
jobs:
 deploy:
   runs-on: ubuntu-latest
   steps:
      - name: Git checkout
        uses: actions/checkout@v2

      - name: Update theme
        run: git submodule update --init --recursive

      - name: Setup hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: "0.93.3"

      - name: Build
        run: hugo -D
        
      - name: Clean old static files
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.HOST }}
          USERNAME: ${{ secrets.USERNAME }}
          PORT: ${{ secrets.PORT }}
          KEY: ${{ secrets.SSHKEY }}
          script: rm -rf /opt/website/public
        
      - name: Copy new static files
        uses: appleboy/scp-action@master
        env:
         HOST: ${{ secrets.HOST }}
         USERNAME: ${{ secrets.USERNAME }}
         PORT: ${{ secrets.PORT }}
         KEY: ${{ secrets.SSHKEY }}
        with:
         source: "./public"
         target: "/opt/website/."

```
