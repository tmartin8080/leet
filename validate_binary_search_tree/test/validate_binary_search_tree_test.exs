defmodule ValidateBinarySearchTreeTest do
  use ExUnit.Case
  import ValidateBinarySearchTree

  describe "is_valid_bst" do
    test "input: root = [2,1,3]" do
      root = %TreeNode{
        val: 2,
        left: %TreeNode{
          val: 1,
          left: nil,
          right: nil
        },
        right: %TreeNode{
          val: 3,
          left: nil,
          right: nil
        }
      }

      assert is_valid_bst(root) == true
    end

    test "input: root = [5,1,4,null,null,3,6]" do
      root = %TreeNode{
        left: %TreeNode{left: nil, right: nil, val: 1},
        right: %TreeNode{
          left: %TreeNode{left: nil, right: nil, val: 3},
          right: %TreeNode{left: nil, right: nil, val: 6},
          val: 4
        },
        val: 5
      }

      assert is_valid_bst(root) == false
    end
  end
end
