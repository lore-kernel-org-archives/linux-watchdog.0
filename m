Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAEA3B38BD
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959602; cv=pass; b=eqjBCib742qsgVorXwRKsydspIBO2yzRWmMiRAePunveZn14W0p29PQq/vq83GCJ7+5PMWFIZFkC987ra/zeCvSN5SXvtrYUnbh7fG6ClowBp56xKwDx377XDNPDHYAN8kRVb94TNl7KhAX0U2F9jEVc7NwQFT2RyYdQWph/yZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959602; c=relaxed/simple;
	bh=TnOuuQl5rwuSs4qW+KCfHV7XEaK2uJM37NChufXTJjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdIM+m2J/dzfbAA9Ip95ADbP54iE/0OwrNIfWOON46AHtEjEcgo/ch9XvwQMcOxRDL2wQlEAgTkPiEOnR6Ri/oCyx3IUGygUzDo+BVuHErixo99P+E6Cj7M9BAT7wmK5Sx1VLFZTMzxxKOB7pL3R+YEICiRjj023QL8uzKsxUlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxtTu8jp; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxtTu8jp"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8b81586dff3so29302736d6.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 22:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959600; cv=none;
        d=google.com; s=arc-20240605;
        b=SNEpp+AB1xd/pGk+1GeAYINsBcs/5pOlZWcQ4xv4tt9021rVFkHH/7qQ1m6zpdmjKe
         PHWx8MeyRTk7OYj9SgI8oSbxF4AVRW0WaJe/WGBGhCxIR0rcW3V6YyTRcgALNYn71pB/
         d3FohCgwU4fnAqxUkppcNk+wgQ8gQNibN6pKgO2nVgMxWKyP/s09/YrjZITwvpYiEFP4
         73WLwplWV9kPhmNs6E8O2fxueRMQx6dYDEhMt7R5Aox6ZtNX92Umh1mF+I9qxQXxEwgH
         A9e1lBp1cglkhdKKT/hzMpcJDWOJLw2hcjFoSGdBkbxeAcEfYDWp2U+JW6EIpgScNYfd
         ataw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TnOuuQl5rwuSs4qW+KCfHV7XEaK2uJM37NChufXTJjM=;
        fh=6F+P5YkiZiqV1VYzAqgVBXE6RM2rRe62+6gQzttI9vM=;
        b=YVC3p9Slk/b8QXtC+m4OMk2TbYek52hx7KbTTG1nWqJwwIoA0J9gPThIUUcwWLWa6y
         a3jU7T4kS7Q7zaQdfpAQ/C5EYQcvJJO/lRRSI6xVEZMHm9m2VQvvjXGpCDSFRVOsOKA1
         hPOm0qeKxaIJLzR3yLUKlgkRhAU9+2FTL5Ii+jALhmIyqrX3q0+c2GBlVON8hQ6fW8uM
         LoXv69ZZ964hWrluUd4qC+OfnqRk0VYTx7WIjdzNTPh8ZWQuHcqwVLSXhemIA9MVgtfW
         xZHPVjqJ4RopU/Af7RMYRuzHVI1chK++C/KIg5Zv+rMpvWVw2QGNIBughuOKCkrkvy+9
         wJ8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777959600; x=1778564400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnOuuQl5rwuSs4qW+KCfHV7XEaK2uJM37NChufXTJjM=;
        b=UxtTu8jpS0Qk6/fBoA22+LaNiit6ZJKf6tDgfnWHmE8zGRRlvRf1iVRpnIi7B/kw3+
         Ot5xxlTG50l5xuXgQWIg5zpM7Z9zWqop512rrFiMTKGswZjQAKtQ/+laXKplBAI2RIKn
         +QMfJtrcAuhkzmMb/3jJkdeXVKtcbAz2pTG+iQnMDtNLZIlRiL4mT3jROd2RW3TXb3wa
         MmvT40OtLvwmxEl9/UlJ3psFE5PDhQfaha3qE6FDjh11PNQ/bVCWjT9nXfX+rTdUk9Cu
         D/0gU595Yg83HQMpf71NnrrsYD2klH6ESoqy9AcfpJnWwDkp66L4JojkuUjdLcamzLGQ
         uR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777959600; x=1778564400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnOuuQl5rwuSs4qW+KCfHV7XEaK2uJM37NChufXTJjM=;
        b=QJxAcH756dykasOI1sVYVwlIzJH8RFSh9CwmnBKtbr1yL/VtAWkAu9Ky5dZ2GC4Hlp
         ynBzOlKiMBS50ERWrdLIBM/2ybhrjW5+fWUvH1Ki8D9zHqJrN0RzPgLPyVyI4jc3x/1r
         LM6LhqscirpJwWshTkqS1WtozShwh+TDkeMAv4JPogw6kNrDqX8X/ioyNf2OR/4B0S2M
         nacTY4Ick2o+D1sUZTgTq0vSCGkekmJPwPNCLQ3vDOyUjqToeiHArBmIG6JpiGpgj2F3
         +IwXsfxG+gx4zpuWBuxftK1QOXdH0GCT3Wgex47Sc9aG7r5AvV694SU/7e2IXxOOKgEW
         ChPQ==
X-Gm-Message-State: AOJu0YyaBMjCaSiziTDJgBIFhS07KjX4xHLtbWi2P0NuGdxlj8NyA+4W
	7Mne/b6oWxWHUMwu2xRwU/KPk2yxdboSUYRmRIhGyQe5b5+M4jG93jG7ZMJ2VXCFWMKFQyN/U64
	NpusvTTuD6Hv0rAG4j6+0NA/H8PNLIVjq5Ixh4h0=
X-Gm-Gg: AeBDieteXGuFb/9LdfgcO2+WYavIAOBSKroFapFSqkVSPIKvOziYzLq2wzk6LugBCtx
	RH+VD/KoAjTR1aPuhSZ3LOaeUlt6H/DrMjY2uMf3R/FSVLUPXdRd8TP50+1zGUbJuXezGkiFCgY
	28O0D1EeONG6/kQUO41nKbgWj9NiTzJAdH9DsZZBkJHyj5XIwSdjfYvvUvFMzF7elJsE3V8Biwp
	VPRi2AGQkbFSOLg9HT35ZyZ5uIRXUvxxrmItnpT4rbxbxKhwHex2ptGQmBQmuMEkvS6eUTdLk1S
	Y/dVb2US59D/LtBJ0kawq0mBIkXFidxvho2wzuSceYyyxOdfb8ZWYRnyFA9n7RLdYi2cvFOizjM
	V5Q0=
X-Received: by 2002:a05:6214:230b:b0:89a:ff2:b8cf with SMTP id
 6a1803df08f44-8badd87572fmr26568096d6.44.1777959600149; Mon, 04 May 2026
 22:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505023007.58175-1-enelsonmoore@gmail.com> <9d134dfa-76be-4242-bae4-c4a02036f53e@roeck-us.net>
In-Reply-To: <9d134dfa-76be-4242-bae4-c4a02036f53e@roeck-us.net>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 4 May 2026 22:39:49 -0700
X-Gm-Features: AVHnY4LAtbZYY3ppf1jgejmaTA7KkZj8ZlcchWqumakLU6442lHn6oiwLHnpfJI
Message-ID: <CADkSEUhJnA0d6hh8vfa8ZBpUDi2GyH9pHYSbRmrRuRNjXcPRig@mail.gmail.com>
Subject: Re: [PATCH] watchdog: remove drivers for discrete ISA WDT cards
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Guenter,

On Mon, May 4, 2026 at 9:59=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
> Umm ... no. Declare them deprecated and announce that they will be remove=
d
> in a later kernel version unless someone speaks up. Do a Google search fo=
r
> "How to deprecate Linux kernel code" and follow the guidance.

In my personal opinion, that isn't necessary and probably wouldn't help.

The kernel tried doing official deprecation anouncements a long time
ago via feature-removal-schedule.txt, but they turned out to be
useless because no one was reading the file. It was removed in commit
9c0ece069b32e8e122aea71aa47181c10eb85ba7 (which I will refrain from
quoting here because it was written in classic Linus style).

Other subsystems have been removing drivers without notification and
only restoring them if someone complains.
For example, see:
- git log drivers/net/ethernet/Makefile (note how fealnx was removed
and restored because someone was using it)
- commit c0fef45dbab0 ("char/mwave: drop it")
- commit 9b12f050c76f ("char: pcmcia: remove all the drivers")

> Also, remember the "one logical change per patch" rule.

I will split this patch in a future version (and remove the
documentation, as pointed out by Sashiko).

I have also made a new version of the it8712f_wdt removal patch (as a
series) which resolves all the transition-related issues pointed out
by Sashiko and makes it87_wdt a drop-in replacement for it. I will
send it after the 24-hour waiting period ends.

Have a nice day!

Ethan
