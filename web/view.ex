defmodule Isis.View do
  use Phoenix.View, root: "web/templates"

  # The quoted expression returned by this block is applied
  # to this module and all other views that use this module.
  using do
    quote do
      # Import common functionality
      import Isis.Router.Helpers

      # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      # Common aliases
      alias Phoenix.Controller.Flash
    end
  end

  # Functions defined here are available to all other views/templates
  def format_error(error) when is_binary(error) do
    {:safe, "<li>#{error}</li>"}
  end
  
  def format_error(errors) when is_map(errors) do
    Enum.map(errors, &format_error/1)
  end
  
  def format_error({k, v}) do
    {:safe, "<li>#{String.capitalize(to_string k)} #{Enum.join(v, " and ")}</li>"}
  end
  
end
