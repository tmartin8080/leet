defmodule TreeNode do
  @type t :: %__MODULE__{
          val: integer,
          left: TreeNode.t() | nil,
          right: TreeNode.t() | nil
        }
  defstruct val: 0, left: nil, right: nil
end

# def validate(node, low=-math.inf, high=math.inf):
# Empty trees are valid BSTs.
# if not node: return True
# The current node's value must be between low and high.
# if node.val <= low or node.val >= high:  return False

# The left and right subtree must also be valid.
# return (validate(node.right, node.val, high) and  validate(node.left, low, node.val))

defmodule BST do
  @min :math.pow(-2, 31)
  @max :math.pow(2, 31) - 1

  @spec is_valid_bst(root :: TreeNode.t() | nil) :: boolean
  def is_valid_bst(root) do
    validate(root, @min, @max)
  end

  # Empty trees are valid BSTs.
  defp validate(nil, _low, _high), do: true

  # The current node's value must be between low and high.
  defp validate(%{val: val}, low, high) when val <= low or val >= high, do: false

  # The left and right subtree must also be valid.
  defp validate(node, low, high) do
    validate(node.right, node.val, high) and validate(node.left, low, node.val)
  end
end
