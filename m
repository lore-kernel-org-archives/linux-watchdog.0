Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8203112DA
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232783; cv=pass; b=J7wlV6ouHcByifBO1kBldL5NGRvVvcoyZ2+Oopsr8Xy68dcu4G6htqMOW49Fjk9nm5cTZUhZajhwCKYz19P3KdSpjJ0RtLjTin2YFncBM6CLUZ8PMKavmumTUG/5eGTvi3ns49DXlZbl9gOlatA3dsanvL12RHV/VpcGSDqLKxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232783; c=relaxed/simple;
	bh=nsp8QbI31oMRqa99SWsppZjKCAYJowiD7RAqLlI512E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6epdhAK7NnVrPPu6mExmoz3lEr5eZp6ziWJKejhxWUEvjxbuj9nLwWo4VRjQ/nlvF6gB80nfhVvCjOtNYNZ1cg/Zn9NDONSFk24SC6oAmChGqaEOjhIXAAaEKaMdI0gAUfL/6OiNryfpbELvMQI9QveU4RRnPqySxT8y9tdi4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdlybIJx; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdlybIJx"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso861538666b.1
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 16:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779232780; cv=none;
        d=google.com; s=arc-20240605;
        b=flx7qEw1rKqaUu4rX5rSNvunp8haRFgsKIBJeLt9HwjtJG7uKdYiSPWy5SMCkNf9Q5
         e5RKD5qqxE5xrpE2hpsfSl1n/dckk7seVFayuSfXWtbABngvj9Dnajydumiu9AvGmevt
         HGOx3wwemtnhBM2ZpS//5WrAL2/6Pl71RIcT2LBJgoh9VWIOr9euXAzs9RcZ8A72+tAG
         n1i1K33zMs5H9Fb3jT2EYngwe/8DN58C5L/yHqwPPnOdlMLfjZ4HtqUZz6+DDi1tzDOi
         TGiNPYmrXy0eEoaWiXNhzHmOhFE2wpSoqENFkgUk7koqMoTZhgRNJ4UpCGBue5uGkUSt
         ro8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZXJaPxbOTZsHyl97EtwLCUN/XKnpAgKrE+PsKlhmts=;
        fh=FJE0Z1GZdAMudjUr2H6FLc0DWrHWA8QakvIVOuQqiKg=;
        b=ZpXKipgWN5GzEJ3oFDuZyY9Tvfzlvsqgm9PCbafWpO/S2Em801IRPdfRRFXom0Te0u
         HgRfy2K5tv7T8b6qDMwBcnSmBPum8RvhN8OwB4fMixWkT2x1vH/nuCArWwOgoV8JLcrG
         mbcwP3GIh5fSDa08PxkrMi2Q6nFPZ2uUSNpI6pSQoXbnt2QNVZly92XcL61ergwDwpZQ
         GN7eUjozcoIlyStc6Nc5MYsa4gfGRx0onMegAGWCTyiymN0PhIsiYVQ96OXas5l+uvlA
         QiRJxwetzvHx4OylAOo3/Vrb0aB0bj7FKGDOMeE/sjohUQFH9HM4yhdReyWdvjfD2pey
         ONjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779232780; x=1779837580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZXJaPxbOTZsHyl97EtwLCUN/XKnpAgKrE+PsKlhmts=;
        b=FdlybIJxMI2m4fzeFFyZ9RNbfesd+ihSd9mCrZpe3rENw5GSi5BIGGBCNjQKJj0jVo
         JdDF7Wci9TfkMV+1Taj9W+05QEP3rcjAcCqTxP9vy7sX1N5koj3yrbKfO3dCTrFGj8vm
         VmvdkngVzVgxIv9GPQ6j4R32e418aOg0dm+JXF/UBJNomrLUGMmqnsG/M31OMnWW97f4
         mMu3br8RQBNvf3ZFi/9Jco+E49kz7wm4Svq8YmbG1hh0cuYsLV9xTudjmMT4T/3/frAi
         SAsCSdbi/0PZ6j1rNssLwg29EjuRc6Zf5F3KaR8G4W/LnpU7kIflsLogOFvyUV4mqGbP
         eaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779232780; x=1779837580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZXJaPxbOTZsHyl97EtwLCUN/XKnpAgKrE+PsKlhmts=;
        b=s/V6KAAId3fVH6GhKHkLUFYrK8pimTBlfhLopEZdMjBTFJmDxuRd0jdODxng0slhlJ
         rzD/nWIwFhCDo+VhvWddCmdqHlPC6t7xSXCu5eUXCK/M4oBNaZwmUP3lh2nPQWmyypv7
         e7PX6LUQcTxTIi5cKzNUxGlsRrpUDz4Rn/ydybX/HPp0WYSHvw3jHBlfmw3Tjc2E5KgA
         gBh8vma3gAbF8uSCIrA7NLXkCg6PoYU+Mz22KCRkJiOHgUg2DXCnAHUScFzMt/jvvlWo
         PU0A6iQs3uV0FT+GDwDn3mxvg/DYmu6dSqaZzxeDx4MVo6xdGz/w9/aLuJ/z2UiKWVHl
         H58g==
X-Gm-Message-State: AOJu0YwbPnMRmabP18dLycnH4O5h5JpE75ycFVLuXqa3ow4/lP8eBHL7
	y3YuLR5X+igKxlD6iADglsYxRf7/OFQ3j6bYSSTPVWSuh7gCQ59vJCzk/hzDoyFQxhrFBiu51pT
	SE9n/rDOnD6OhFuNazM3B3X94SXbEzTo=
X-Gm-Gg: Acq92OGeb8gbyERRrnOjXWVXKTidDVCVqmV+TT0gNSy0deZzYpfADSX8+yER6ShSByM
	XrISQQZ/oHTBwlR3JvLhA59GG2XOXUCvGkpwPFanSa05D+ouUf3vNZ/le93Lq1q8NgQvgIua8DH
	qKQau4o8zwl0cSMZTIl4CFSV/cNNrXgoc8T0Q1Fwk/Gv+G+2TyfZa7P8ThtsDKxfjQ74F8ynkXg
	05kbRkAnTA2XI2ZPdpoRK/ZNq5P4OKq8xTg6qEf+/ZnF6p7MlP6cvKOuFz2Gr0vUKra9Om65D+1
	Bxl3vC7GAPjh0A1GE692GuvifsxpiYi8GDA6HyNfCBc/4DqvzXNhF09QHb+rigJA9mWnmMSs0Qv
	WyQclmDr6aT5+TIZSupLLj26KyI47PeFMe2alUOYDNUvpLZDm1xmzzOf33A==
X-Received: by 2002:a17:907:9801:b0:bd0:8e74:85a3 with SMTP id
 a640c23a62f3a-bd5178f9146mr1222230966b.26.1779232779968; Tue, 19 May 2026
 16:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519214229.16656-1-rosenp@gmail.com> <61a24e1e-2490-4791-811a-3c1c85fda05b@roeck-us.net>
 <CAKxU2N8pzaWow-pQ=gTkyvD=4JpZF77SN7F9pF9Ty78vkj65xQ@mail.gmail.com> <a74ce1b6-06ce-4a30-a53d-79070a272a2a@roeck-us.net>
In-Reply-To: <a74ce1b6-06ce-4a30-a53d-79070a272a2a@roeck-us.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 19 May 2026 16:19:28 -0700
X-Gm-Features: AVHnY4L8Xru-9WqPkQrKSpAZwVJlfMnZfG1felunmG3cZ-rEQZLX0iYiAb1EKwM
Message-ID: <CAKxU2N-2rA7GQZGoBQdkJLvWeSZNbfUqzNvEOoBskzc1FjcH=A@mail.gmail.com>
Subject: Re: [PATCH] watchdog: orion_wdt: Use devm APIs for clock and watchdog management
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:10=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 5/19/26 15:44, Rosen Penev wrote:
> > On Tue, May 19, 2026 at 3:34=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> On Tue, May 19, 2026 at 02:42:29PM -0700, Rosen Penev wrote:
> >>> Replace clk_get/clk_prepare_enable/clk_put with devm_clk_get_enabled
> >>> and devm_clk_get_optional_enabled so the clock lifecycle is managed
> >>> automatically. Switch to devm_watchdog_register_device to eliminate
> >>> the manual remove callback and the disable_clk error path.
> >>>
> >>> Switching to devm in these functions is fine as the proper
> >>> platform_device is passed in.
> >>>
> >>> Assisted-by: Claude:Sonnet-4.6
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>
> >> drivers/watchdog/orion_wdt.c: In function 'orion_wdt_clock_init':
> >> drivers/watchdog/orion_wdt.c:82:13: error: unused variable 'ret' [-Wer=
ror=3Dunused-variable]
> >>     82 |         int ret;
> >>        |             ^~~
> >> drivers/watchdog/orion_wdt.c: In function 'armada370_wdt_clock_init':
> >> drivers/watchdog/orion_wdt.c:95:13: error: unused variable 'ret' [-Wer=
ror=3Dunused-variable]
> >>     95 |         int ret;
> >>        |             ^~~
> >> drivers/watchdog/orion_wdt.c: In function 'armada375_wdt_clock_init':
> >> drivers/watchdog/orion_wdt.c:113:13: error: unused variable 'ret' [-We=
rror=3Dunused-variable]
> >>    113 |         int ret;
> >>        |             ^~~
> >> drivers/watchdog/orion_wdt.c: In function 'armadaxp_wdt_clock_init':
> >> drivers/watchdog/orion_wdt.c:144:13: error: unused variable 'ret' [-We=
rror=3Dunused-variable]
> >>    144 |         int ret;
> >>
> >> On top of that, the APIs are not 1:1 replaceable.
> >>
> >> I am so tired of this. Please stop. I am no longer going to accept any=
 "cleanup"
> >> patches.
> > If I don't, the bot yells at me. If I do, you yell at me. It seems I
> > am at an impasse.
>
> The above is the compiler yelling at you.
No I mean my watchdog: orion: Use of_device_get_match_data() patch
resulted in the AI complaining about clock code that I didn't touch.

The above errors are me compiling for powerpc when there's a depend on ARM.
> Guenter
>
