
exception NoDeepThought;

(* the things to paste *)
datatype tile = BLACKHOLE | LASER_GUN | MARVIN | FOURTY_TWO | DEEPTHOUGHT;
datatype direction = DOWN | RIGHT;
datatype 'a Seq = Nil | Cons of 'a * (unit -> 'a Seq);
datatype 'a DSeq = DNil | DCons of 'a * (unit -> 'a DSeq) * (unit -> 'a DSeq);
exception NoDeepThought;


val good_path = fn path =>
  let
    fun check Nil _ = false
      | check (Cons(x, xf)) has_laser =
          case x of
              BLACKHOLE => false
            | MARVIN => if has_laser then check (xf()) has_laser else false
            | FOURTY_TWO => check (xf()) true
            | LASER_GUN => check (xf()) has_laser
            | DEEPTHOUGHT => true
  in
    check path false
  end;


val get_flat_path = fn matrix =>
  fn directions =>
    let
      fun follow DNil _ _ = Nil
        | follow (DCons(x, d, r)) Nil _ = Cons (x, fn () => Nil)
        | follow (DCons(x, d, r)) (Cons(dir, next_dir)) path_fn =
            let
              val next_matrix = case dir of
                  DOWN => d()
                | RIGHT => r()
            in
              Cons(x, fn () => follow next_matrix (next_dir()) path_fn)
            end
    in
      follow matrix directions (fn () => Nil)
    end;


val find_all_paths = fn (rows, cols) =>
  let
    fun go (i,j) =
      if i = 0 andalso j = 0 then [Nil]
      else
        let
          val from_up = if i > 0 then List.map (fn p => Cons(DOWN, fn () => p)) (go(i-1,j)) else []
          val from_left = if j > 0 then List.map (fn p => Cons(RIGHT, fn () => p)) (go(i,j-1)) else []
        in
          from_up @ from_left
        end
  in
    go (rows, cols)
  end;


val minimal_distance_for_deep_thought = fn matrix =>
  let
    val max_dim = 10

    (* Flattening the list of lists of lists into a flat list of lazy direction sequences *)
    val paths : direction Seq list =
      List.concat (
        List.tabulate (max_dim, fn i =>
          List.concat (
            List.tabulate (max_dim, fn j =>
              find_all_paths (i, j)
            )
          )
        )
      )

    fun first_valid [] = NONE
      | first_valid (p::ps) =
          let
            val flat = get_flat_path matrix p
          in
            if good_path flat then SOME (p, flat) else first_valid ps
          end

    fun count_len Nil = 0
      | count_len (Cons(_, xf)) = 1 + count_len (xf())

  in
    case first_valid paths of
        NONE => raise NoDeepThought
      | SOME (_, flat) => count_len flat
  end;



