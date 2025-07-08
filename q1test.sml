
(* מטריצה עצלה לבדיקה *)
val test_matrix =
  DCons (FOURTY_TWO,
    fn () => DCons (LASER_GUN, fn () => DNil, fn () => DNil),
    fn () => DCons (MARVIN, fn () => DCons (DEEPTHOUGHT, fn () => DNil, fn () => DNil), fn () => DNil)
  );

(* יצירת מסלול לבדיקה *)
val test_path1 = Cons (RIGHT, fn () => Cons (DOWN, fn () => Nil));
val flat1 = get_flat_path test_matrix test_path1;
val () = print ("Test path 1 is good? " ^ Bool.toString (good_path flat1) ^ "\n");

val test_path2 = Cons (DOWN, fn () => Cons (RIGHT, fn () => Nil));
val flat2 = get_flat_path test_matrix test_path2;
val () = print ("Test path 2 is good? " ^ Bool.toString (good_path flat2) ^ "\n");

(* בדיקת הפונקציה הראשית – צריכה להחזיר 3 *)
val result = minimal_distance_for_deep_thought test_matrix;
val () = print ("Minimal distance to DeepThought: " ^ Int.toString result ^ "\n");



(* 🧪 פלט מצופה: *)

(* Test path 1 is good? true *)
(* Test path 2 is good? true *)
(* Minimal distance to DeepThought: 3 *)


