variable "network" {
  type = object({
    name = string
  })
}

variable "member" {
  type = object({
    name = string
    id = string
  })
}
