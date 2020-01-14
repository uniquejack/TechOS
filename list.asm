
_list_new:

;list.c,30 :: 		plist_t list_new()
;list.c,34 :: 		list = (plist_t) Malloc(sizeof(list_t));
	MOVLW       8
	MOVWF       FARG_Malloc_Size+0 
	MOVLW       0
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVF        R0, 0 
	MOVWF       list_new_list_L0+0 
	MOVF        R1, 0 
	MOVWF       list_new_list_L0+1 
;list.c,36 :: 		if (!list)
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_list_new0
;list.c,37 :: 		return NULL;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_list_new
L_list_new0:
;list.c,39 :: 		list->first = NULL;
	MOVFF       list_new_list_L0+0, FSR1L+0
	MOVFF       list_new_list_L0+1, FSR1H+0
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;list.c,40 :: 		list->last = NULL;
	MOVLW       2
	ADDWF       list_new_list_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      list_new_list_L0+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;list.c,42 :: 		list->node_type = sizeof(node_t);
	MOVLW       6
	ADDWF       list_new_list_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      list_new_list_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;list.c,44 :: 		return list;
	MOVF        list_new_list_L0+0, 0 
	MOVWF       R0 
	MOVF        list_new_list_L0+1, 0 
	MOVWF       R1 
;list.c,45 :: 		}
L_end_list_new:
	RETURN      0
; end of _list_new

_list_destroy:

;list.c,47 :: 		void list_destroy(plist_t list)
;list.c,50 :: 		if (!list) return;
	MOVF        FARG_list_destroy_list+0, 0 
	IORWF       FARG_list_destroy_list+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_list_destroy1
	GOTO        L_end_list_destroy
L_list_destroy1:
;list.c,52 :: 		for (node = list->first; node; node = node->next)
	MOVFF       FARG_list_destroy_list+0, FSR0L+0
	MOVFF       FARG_list_destroy_list+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       list_destroy_node_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       list_destroy_node_L0+1 
L_list_destroy2:
	MOVF        list_destroy_node_L0+0, 0 
	IORWF       list_destroy_node_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_list_destroy3
;list.c,53 :: 		FreeMem((void*)node, sizeof(node_t));
	MOVF        list_destroy_node_L0+0, 0 
	MOVWF       FARG_FreeMem_P+0 
	MOVF        list_destroy_node_L0+1, 0 
	MOVWF       FARG_FreeMem_P+1 
	MOVLW       6
	MOVWF       FARG_FreeMem_Size+0 
	MOVLW       0
	MOVWF       FARG_FreeMem_Size+1 
	CALL        _FreeMem+0, 0
;list.c,52 :: 		for (node = list->first; node; node = node->next)
	MOVFF       list_destroy_node_L0+0, FSR0L+0
	MOVFF       list_destroy_node_L0+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       list_destroy_node_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       list_destroy_node_L0+1 
;list.c,53 :: 		FreeMem((void*)node, sizeof(node_t));
	GOTO        L_list_destroy2
L_list_destroy3:
;list.c,55 :: 		FreeMem((void*)list, sizeof(list_t));
	MOVF        FARG_list_destroy_list+0, 0 
	MOVWF       FARG_FreeMem_P+0 
	MOVF        FARG_list_destroy_list+1, 0 
	MOVWF       FARG_FreeMem_P+1 
	MOVLW       8
	MOVWF       FARG_FreeMem_Size+0 
	MOVLW       0
	MOVWF       FARG_FreeMem_Size+1 
	CALL        _FreeMem+0, 0
;list.c,56 :: 		}
L_end_list_destroy:
	RETURN      0
; end of _list_destroy

_list_size:

;list.c,58 :: 		uint16 list_size(plist_t list)
;list.c,60 :: 		return list->size;
	MOVLW       4
	ADDWF       FARG_list_size_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_size_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
;list.c,61 :: 		}
L_end_list_size:
	RETURN      0
; end of _list_size

_list_begin:

;list.c,63 :: 		pnode_t list_begin(plist_t list)
;list.c,65 :: 		return list->first;
	MOVFF       FARG_list_begin_list+0, FSR0L+0
	MOVFF       FARG_list_begin_list+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
;list.c,66 :: 		}
L_end_list_begin:
	RETURN      0
; end of _list_begin

_node_create:

;list.c,68 :: 		pnode_t node_create(plist_t list, void* pdata)
;list.c,72 :: 		node = (pnode_t) Malloc(list->node_type);
	MOVLW       6
	ADDWF       FARG_node_create_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_node_create_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Malloc_Size+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVF        R0, 0 
	MOVWF       node_create_node_L0+0 
	MOVF        R1, 0 
	MOVWF       node_create_node_L0+1 
;list.c,74 :: 		if (!node)
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_node_create5
;list.c,75 :: 		return NULL;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_node_create
L_node_create5:
;list.c,77 :: 		node->next = NULL;
	MOVFF       node_create_node_L0+0, FSR1L+0
	MOVFF       node_create_node_L0+1, FSR1H+0
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;list.c,78 :: 		node->previous = NULL;
	MOVLW       2
	ADDWF       node_create_node_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      node_create_node_L0+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;list.c,79 :: 		node->pdata = pdata;
	MOVLW       4
	ADDWF       node_create_node_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      node_create_node_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_node_create_pdata+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_node_create_pdata+1, 0 
	MOVWF       POSTINC1+0 
;list.c,81 :: 		return node;
	MOVF        node_create_node_L0+0, 0 
	MOVWF       R0 
	MOVF        node_create_node_L0+1, 0 
	MOVWF       R1 
;list.c,82 :: 		}
L_end_node_create:
	RETURN      0
; end of _node_create

_list_insert:

;list.c,84 :: 		pnode_t list_insert(plist_t list, void* pdata)
;list.c,88 :: 		if (!list)
	MOVF        FARG_list_insert_list+0, 0 
	IORWF       FARG_list_insert_list+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_list_insert6
;list.c,89 :: 		return NULL;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_list_insert
L_list_insert6:
;list.c,91 :: 		node = node_create(list, pdata);
	MOVF        FARG_list_insert_list+0, 0 
	MOVWF       FARG_node_create_list+0 
	MOVF        FARG_list_insert_list+1, 0 
	MOVWF       FARG_node_create_list+1 
	MOVF        FARG_list_insert_pdata+0, 0 
	MOVWF       FARG_node_create_pdata+0 
	MOVF        FARG_list_insert_pdata+1, 0 
	MOVWF       FARG_node_create_pdata+1 
	CALL        _node_create+0, 0
	MOVF        R0, 0 
	MOVWF       list_insert_node_L0+0 
	MOVF        R1, 0 
	MOVWF       list_insert_node_L0+1 
;list.c,93 :: 		if (!list->first)
	MOVFF       FARG_list_insert_list+0, FSR0L+0
	MOVFF       FARG_list_insert_list+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_list_insert7
;list.c,94 :: 		list->first = list->last = node;
	MOVF        FARG_list_insert_list+0, 0 
	MOVWF       R2 
	MOVF        FARG_list_insert_list+1, 0 
	MOVWF       R3 
	MOVLW       2
	ADDWF       FARG_list_insert_list+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_list_insert_list+1, 0 
	MOVWF       R1 
	MOVFF       R0, FSR1L+0
	MOVFF       R1, FSR1H+0
	MOVF        list_insert_node_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        list_insert_node_L0+1, 0 
	MOVWF       POSTINC1+0 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_list_insert8
L_list_insert7:
;list.c,96 :: 		list->last->next = node;
	MOVLW       2
	ADDWF       FARG_list_insert_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_insert_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R0, FSR1L+0
	MOVFF       R1, FSR1H+0
	MOVF        list_insert_node_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        list_insert_node_L0+1, 0 
	MOVWF       POSTINC1+0 
;list.c,97 :: 		node->previous = list->last;
	MOVLW       2
	ADDWF       list_insert_node_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      list_insert_node_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       2
	ADDWF       FARG_list_insert_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_insert_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;list.c,98 :: 		list->last = node;
	MOVLW       2
	ADDWF       FARG_list_insert_list+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_list_insert_list+1, 0 
	MOVWF       FSR1L+1 
	MOVF        list_insert_node_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        list_insert_node_L0+1, 0 
	MOVWF       POSTINC1+0 
;list.c,99 :: 		}
L_list_insert8:
;list.c,101 :: 		return node;
	MOVF        list_insert_node_L0+0, 0 
	MOVWF       R0 
	MOVF        list_insert_node_L0+1, 0 
	MOVWF       R1 
;list.c,102 :: 		}
L_end_list_insert:
	RETURN      0
; end of _list_insert

_list_insert_after:

;list.c,104 :: 		pnode_t list_insert_after(plist_t list, pnode_t node, void* pdata)
;list.c,108 :: 		if (!list)
	MOVF        FARG_list_insert_after_list+0, 0 
	IORWF       FARG_list_insert_after_list+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_list_insert_after9
;list.c,109 :: 		return NULL;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_list_insert_after
L_list_insert_after9:
;list.c,111 :: 		newnode = node_create(list, pdata);
	MOVF        FARG_list_insert_after_list+0, 0 
	MOVWF       FARG_node_create_list+0 
	MOVF        FARG_list_insert_after_list+1, 0 
	MOVWF       FARG_node_create_list+1 
	MOVF        FARG_list_insert_after_pdata+0, 0 
	MOVWF       FARG_node_create_pdata+0 
	MOVF        FARG_list_insert_after_pdata+1, 0 
	MOVWF       FARG_node_create_pdata+1 
	CALL        _node_create+0, 0
	MOVF        R0, 0 
	MOVWF       list_insert_after_newnode_L0+0 
	MOVF        R1, 0 
	MOVWF       list_insert_after_newnode_L0+1 
;list.c,113 :: 		if (list->last == node) {
	MOVLW       2
	ADDWF       FARG_list_insert_after_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_insert_after_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       FARG_list_insert_after_node+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__list_insert_after35
	MOVF        FARG_list_insert_after_node+0, 0 
	XORWF       R1, 0 
L__list_insert_after35:
	BTFSS       STATUS+0, 2 
	GOTO        L_list_insert_after10
;list.c,114 :: 		list->last->next = newnode;
	MOVLW       2
	ADDWF       FARG_list_insert_after_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_insert_after_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R0, FSR1L+0
	MOVFF       R1, FSR1H+0
	MOVF        list_insert_after_newnode_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        list_insert_after_newnode_L0+1, 0 
	MOVWF       POSTINC1+0 
;list.c,115 :: 		newnode->previous = list->last;
	MOVLW       2
	ADDWF       list_insert_after_newnode_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      list_insert_after_newnode_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       2
	ADDWF       FARG_list_insert_after_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_insert_after_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;list.c,116 :: 		list->last = newnode;
	MOVLW       2
	ADDWF       FARG_list_insert_after_list+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_list_insert_after_list+1, 0 
	MOVWF       FSR1L+1 
	MOVF        list_insert_after_newnode_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        list_insert_after_newnode_L0+1, 0 
	MOVWF       POSTINC1+0 
;list.c,117 :: 		} else {
	GOTO        L_list_insert_after11
L_list_insert_after10:
;list.c,118 :: 		newnode->next = node->next;
	MOVFF       list_insert_after_newnode_L0+0, FSR1L+0
	MOVFF       list_insert_after_newnode_L0+1, FSR1H+0
	MOVFF       FARG_list_insert_after_node+0, FSR0L+0
	MOVFF       FARG_list_insert_after_node+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;list.c,119 :: 		newnode->previous = node;
	MOVLW       2
	ADDWF       list_insert_after_newnode_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      list_insert_after_newnode_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_list_insert_after_node+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_list_insert_after_node+1, 0 
	MOVWF       POSTINC1+0 
;list.c,120 :: 		node->next = newnode;
	MOVFF       FARG_list_insert_after_node+0, FSR1L+0
	MOVFF       FARG_list_insert_after_node+1, FSR1H+0
	MOVF        list_insert_after_newnode_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        list_insert_after_newnode_L0+1, 0 
	MOVWF       POSTINC1+0 
;list.c,121 :: 		}
L_list_insert_after11:
;list.c,123 :: 		return newnode;
	MOVF        list_insert_after_newnode_L0+0, 0 
	MOVWF       R0 
	MOVF        list_insert_after_newnode_L0+1, 0 
	MOVWF       R1 
;list.c,124 :: 		}
L_end_list_insert_after:
	RETURN      0
; end of _list_insert_after

_list_erase:

;list.c,126 :: 		bool list_erase(plist_t list, pnode_t cmp_node)
;list.c,130 :: 		if (!list || !cmp_node)
	MOVF        FARG_list_erase_list+0, 0 
	IORWF       FARG_list_erase_list+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__list_erase27
	MOVF        FARG_list_erase_cmp_node+0, 0 
	IORWF       FARG_list_erase_cmp_node+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__list_erase27
	GOTO        L_list_erase14
L__list_erase27:
;list.c,131 :: 		return false;
	CLRF        R0 
	GOTO        L_end_list_erase
L_list_erase14:
;list.c,133 :: 		if (list->first == cmp_node) {
	MOVFF       FARG_list_erase_list+0, FSR0L+0
	MOVFF       FARG_list_erase_list+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       FARG_list_erase_cmp_node+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__list_erase37
	MOVF        FARG_list_erase_cmp_node+0, 0 
	XORWF       R1, 0 
L__list_erase37:
	BTFSS       STATUS+0, 2 
	GOTO        L_list_erase15
;list.c,134 :: 		list->first = cmp_node->next;
	MOVFF       FARG_list_erase_list+0, FSR1L+0
	MOVFF       FARG_list_erase_list+1, FSR1H+0
	MOVFF       FARG_list_erase_cmp_node+0, FSR0L+0
	MOVFF       FARG_list_erase_cmp_node+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;list.c,135 :: 		cmp_node->next->previous = NULL;
	MOVFF       FARG_list_erase_cmp_node+0, FSR0L+0
	MOVFF       FARG_list_erase_cmp_node+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;list.c,136 :: 		FreeMem((char*)cmp_node, sizeof(node));
	MOVF        FARG_list_erase_cmp_node+0, 0 
	MOVWF       FARG_FreeMem_P+0 
	MOVF        FARG_list_erase_cmp_node+1, 0 
	MOVWF       FARG_FreeMem_P+1 
	MOVLW       2
	MOVWF       FARG_FreeMem_Size+0 
	MOVLW       0
	MOVWF       FARG_FreeMem_Size+1 
	CALL        _FreeMem+0, 0
;list.c,137 :: 		return true;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_list_erase
;list.c,138 :: 		} else if (list->last == cmp_node) {
L_list_erase15:
	MOVLW       2
	ADDWF       FARG_list_erase_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_erase_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       FARG_list_erase_cmp_node+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__list_erase38
	MOVF        FARG_list_erase_cmp_node+0, 0 
	XORWF       R1, 0 
L__list_erase38:
	BTFSS       STATUS+0, 2 
	GOTO        L_list_erase17
;list.c,139 :: 		list->last = cmp_node->previous;
	MOVLW       2
	ADDWF       FARG_list_erase_list+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_list_erase_list+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       2
	ADDWF       FARG_list_erase_cmp_node+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_erase_cmp_node+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;list.c,140 :: 		list->last->next = NULL;
	MOVLW       2
	ADDWF       FARG_list_erase_list+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_erase_list+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R0, FSR1L+0
	MOVFF       R1, FSR1H+0
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;list.c,141 :: 		FreeMem((char*)cmp_node, sizeof(node));
	MOVF        FARG_list_erase_cmp_node+0, 0 
	MOVWF       FARG_FreeMem_P+0 
	MOVF        FARG_list_erase_cmp_node+1, 0 
	MOVWF       FARG_FreeMem_P+1 
	MOVLW       2
	MOVWF       FARG_FreeMem_Size+0 
	MOVLW       0
	MOVWF       FARG_FreeMem_Size+1 
	CALL        _FreeMem+0, 0
;list.c,142 :: 		return true;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_list_erase
;list.c,143 :: 		}
L_list_erase17:
;list.c,152 :: 		node = cmp_node->previous;
	MOVLW       2
	ADDWF       FARG_list_erase_cmp_node+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_list_erase_cmp_node+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       list_erase_node_L0+0 
	MOVF        R3, 0 
	MOVWF       list_erase_node_L0+1 
;list.c,154 :: 		node->next = cmp_node->next;
	MOVFF       FARG_list_erase_cmp_node+0, FSR0L+0
	MOVFF       FARG_list_erase_cmp_node+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;list.c,155 :: 		cmp_node->next->previous = node;
	MOVFF       FARG_list_erase_cmp_node+0, FSR0L+0
	MOVFF       FARG_list_erase_cmp_node+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        list_erase_node_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        list_erase_node_L0+1, 0 
	MOVWF       POSTINC1+0 
;list.c,156 :: 		FreeMem((char*)cmp_node, sizeof(node));
	MOVF        FARG_list_erase_cmp_node+0, 0 
	MOVWF       FARG_FreeMem_P+0 
	MOVF        FARG_list_erase_cmp_node+1, 0 
	MOVWF       FARG_FreeMem_P+1 
	MOVLW       2
	MOVWF       FARG_FreeMem_Size+0 
	MOVLW       0
	MOVWF       FARG_FreeMem_Size+1 
	CALL        _FreeMem+0, 0
;list.c,157 :: 		return true;
	MOVLW       1
	MOVWF       R0 
;list.c,158 :: 		}
L_end_list_erase:
	RETURN      0
; end of _list_erase

_list_foreach:

;list.c,160 :: 		void list_foreach(plist_t list, void (*func)(void*))
;list.c,163 :: 		if (!list) return;
	MOVF        FARG_list_foreach_list+0, 0 
	IORWF       FARG_list_foreach_list+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_list_foreach18
	GOTO        L_end_list_foreach
L_list_foreach18:
;list.c,165 :: 		for (node = list->first; node; node = node->next)
	MOVFF       FARG_list_foreach_list+0, FSR0L+0
	MOVFF       FARG_list_foreach_list+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       list_foreach_node_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       list_foreach_node_L0+1 
L_list_foreach19:
	MOVF        list_foreach_node_L0+0, 0 
	IORWF       list_foreach_node_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_list_foreach20
;list.c,166 :: 		func(node->pdata);
	MOVLW       4
	ADDWF       list_foreach_node_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      list_foreach_node_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        FARG_list_foreach_func+2, 0 
	MOVWF       FSR1+0 
	MOVF        FARG_list_foreach_func+3, 0 
	MOVWF       FSR1+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_list_foreach_func+0, 0 
	MOVWF       R0 
	MOVF        FARG_list_foreach_func+1, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
;list.c,165 :: 		for (node = list->first; node; node = node->next)
	MOVFF       list_foreach_node_L0+0, FSR0L+0
	MOVFF       list_foreach_node_L0+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       list_foreach_node_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       list_foreach_node_L0+1 
;list.c,166 :: 		func(node->pdata);
	GOTO        L_list_foreach19
L_list_foreach20:
;list.c,167 :: 		}
L_end_list_foreach:
	RETURN      0
; end of _list_foreach

_list_find:

;list.c,169 :: 		pnode_t list_find(plist_t list, int (*func)(void*, void*), void *pdata)
;list.c,172 :: 		if (!list) return NULL;
	MOVF        FARG_list_find_list+0, 0 
	IORWF       FARG_list_find_list+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_list_find22
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_list_find
L_list_find22:
;list.c,174 :: 		for (node = list->first; node; node = node->next) {
	MOVFF       FARG_list_find_list+0, FSR0L+0
	MOVFF       FARG_list_find_list+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       list_find_node_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       list_find_node_L0+1 
L_list_find23:
	MOVF        list_find_node_L0+0, 0 
	IORWF       list_find_node_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_list_find24
;list.c,175 :: 		if (!func(node->pdata, pdata))
	MOVLW       4
	ADDWF       list_find_node_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      list_find_node_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        FARG_list_find_func+2, 0 
	MOVWF       FSR1+0 
	MOVF        FARG_list_find_func+3, 0 
	MOVWF       FSR1+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_list_find_pdata+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_list_find_pdata+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_list_find_func+0, 0 
	MOVWF       R0 
	MOVF        FARG_list_find_func+1, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_list_find26
;list.c,176 :: 		return node;
	MOVF        list_find_node_L0+0, 0 
	MOVWF       R0 
	MOVF        list_find_node_L0+1, 0 
	MOVWF       R1 
	GOTO        L_end_list_find
L_list_find26:
;list.c,174 :: 		for (node = list->first; node; node = node->next) {
	MOVFF       list_find_node_L0+0, FSR0L+0
	MOVFF       list_find_node_L0+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       list_find_node_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       list_find_node_L0+1 
;list.c,177 :: 		}
	GOTO        L_list_find23
L_list_find24:
;list.c,179 :: 		return NULL;
	CLRF        R0 
	CLRF        R1 
;list.c,180 :: 		}
L_end_list_find:
	RETURN      0
; end of _list_find