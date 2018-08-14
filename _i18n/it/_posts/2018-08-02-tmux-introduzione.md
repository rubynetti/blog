---
layout: post
title:  Introduzione all'uso di tmux
date:   2018-08-02 17:02:22 +0200
categories: tmux
toc: true
---

# Tmux, introduzione all'uso

## Introduzione all'uso

Questo sono i miei appunti per imparare ad usare **tmux**.

- *ctrl + b e poi c* per creare una nuova finestra.
- *ctrl + b e poi n* per andare alla finestra successiva.
- *ctrl + b e poi NUMERO* per andare al numero della finestra desiderato.
- *ctrl + b e poi virgola* per poter cambiare il nome alla finestra corrente.
- *ctrl + b e poi x* per chiudere il pannello selezionato.

## Come posso configurarlo?

Per poterlo personalizzare è necessario modificare il file tmux.conf che si trova all'interno della cartella principale dell'utente (_home folder_).

## Come fargli aprire l'ultima cartella esplorata?

Sempre usando il file di configurazione.
Ecco la porzione di configurazione che uso nel mio computer:

```bash
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
```

## Come posso copiare e incollare?

Per poter compiare e incollare bisogna usare la seguente lista di operazioni:

- *ctrl + b e poi [* in questo modo si entra nella modalità copia.
- *ctrl + b e poi spazio* per poter selezionare la porzione di testo che si vuole copiare.
- *ctrl + b e poi ]* per incollare il testo selezionato.

La risposta alla domanda la ho trovata come spesso accade all'interno di [stackoverflow](https://unix.stackexchange.com/questions/12032/how-to-create-a-new-window-on-the-current-directory-in-tmux).

## Come posso elencare le sessioni?

Per elencare le sessioni puoi usare il semplice comando: "tmux ls".

## Come posso cambiare una sessione?

Puoi cambiare una sessione schiacciando **control + b** e poi *s*.

## Come posso cancellare il buffer come con iterm?

Puoi cancellare il buffer come con iterm attraverso l'uso di una scorciatoia da impostare all'interno del file di configurazione.

```bash
bind -n C-k send-keys -R \; send-keys C-l \; clear-history
```

Fonte: [notes.jerzygangi.com](http://notes.jerzygangi.com/the-only-way-that-actually-works-to-clear-the-screen-in-tmux/)

# Extra

## Come posso contare il numero di parole in vi?

Per poter controllare il numero di parole in vi puoi schiacciare g e poi control + g.

## Come posso fare copia e incolla?

Puoi copiare e incollare col mouse tenendo premuto il pulsante **shift**.
