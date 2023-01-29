defmodule AddTwoNumbersTest do
  use ExUnit.Case
  import AddTwoNumbers

  test "adds 3-digit lists" do
    l1 = %ListNode{next: %ListNode{next: %ListNode{next: nil, val: 3}, val: 4}, val: 2}
    l2 = %ListNode{next: %ListNode{next: %ListNode{next: nil, val: 4}, val: 6}, val: 5}

    assert add_two_numbers(l1, l2) == %ListNode{
             val: 7,
             next: %ListNode{val: 0, next: %ListNode{val: 8, next: nil}}
           }
  end

  test "adds zero lists" do
    l1 = %ListNode{next: nil, val: 0}
    l2 = %ListNode{next: nil, val: 0}
    assert add_two_numbers(l1, l2) == %ListNode{val: 0, next: nil}
  end

  test "adds 9s lists" do
    l1 = %ListNode{
      next: %ListNode{
        next: %ListNode{
          next: %ListNode{
            next: %ListNode{
              next: %ListNode{next: %ListNode{next: nil, val: 9}, val: 9},
              val: 9
            },
            val: 9
          },
          val: 9
        },
        val: 9
      },
      val: 9
    }

    l2 = %ListNode{
      next: %ListNode{
        next: %ListNode{next: %ListNode{next: nil, val: 9}, val: 9},
        val: 9
      },
      val: 9
    }

    assert add_two_numbers(l1, l2) == %ListNode{
             val: 8,
             next: %ListNode{
               val: 9,
               next: %ListNode{
                 val: 9,
                 next: %ListNode{
                   val: 9,
                   next: %ListNode{
                     val: 0,
                     next: %ListNode{
                       val: 0,
                       next: %ListNode{val: 0, next: %ListNode{val: 1, next: nil}}
                     }
                   }
                 }
               }
             }
           }
  end
end
