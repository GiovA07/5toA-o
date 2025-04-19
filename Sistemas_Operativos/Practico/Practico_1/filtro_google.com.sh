#!/bin/bash
# Contar las direcciones de correo que terminan en @google.com
grep -E '@google\.com$' $1 | wc -l
