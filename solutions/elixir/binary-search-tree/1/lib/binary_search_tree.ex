
defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: root, left: left, right: right} = tree, data) do
    if data <= root do
      new_left = if is_nil(left), do: new(data), else: insert(left, data)
      %{tree | left: new_left}
    else
      new_right = if is_nil(right), do: new(data), else: insert(right, data)
      %{tree | right: new_right}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(%{left: left, data: data, right: right}) do
    (if left, do: in_order(left), else: []) ++
      [data] ++
      (if right, do: in_order(right), else: [])
  end
end
