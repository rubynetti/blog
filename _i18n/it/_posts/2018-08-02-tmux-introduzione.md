---
layout: post
title:  Introduzione all'uso di Tmux
date:   2018-08-02 17:02:22 +0200
categories: tmux
---

# Tmux, introduzione all'uso

## Introduzione all'uso di Tmux

Questo sono i miei appunti per imparare ad usare **tmux**.

- *ctrl + b e poi c* per creare una nuova finestra.
- *ctrl + b e poi n* per andare alla finestra successiva.
- *ctrl + b e poi NUMERO* per andare al numero della finestra desiderato.
- *ctrl + b e poi virgola* per poter cambiare il nome alla finestra corrente.

## Come posso configurare tmux?

Per poter personalizzare *tmux* è necessario modificare il file tmux.conf che si trova all'interno della cartella principale dell'utente (_home folder_).

## Come posso copiare e incollare con Tmux?

Per poter compiare e incollare con tmux bisogna usare la seguente lista di operazioni:

- *ctrl + b e poi [* in questo modo si entra nella modalità copia.
- *ctrl + b e poi spazio* per poter selezionare la porzione di testo che si vuole copiare.
- *ctrl + b e poi ]* per incollare il testo selezionato.

## Come posso elencare le sessioni di tmux?

Per elencare le sessioni di tmux puoi usare il semplice comando: "tmux ls".

## Come posso cambiare una sessione di tmux?

Puoi cambiare una sessione di tmux schiacciando **control + b** e poi *s*.

## Come posso cancellare il buffer di tmux come con iterm?

Puoi cancellare il buffer come con iterm attraverso l'uso di una scorciatoia da impostare all'interno del file di configurazione di tmux.

    bind -n C-k send-keys -R \; send-keys C-l \; clear-history
    # Fonte: http://notes.jerzygangi.com/the-only-way-that-actually-works-to-clear-the-screen-in-tmux/

## Come posso contare il numero di parole in vi?

Per poter controllare il numero di parole in vi puoi schiacciare g e poi control + g.

## Come posso fare copia e incolla col mouse con tmux?

Puoi copiare e incollare col mouse tenendo premuto il pulsante **shift**.
