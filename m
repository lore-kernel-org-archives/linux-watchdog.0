Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29606457E69
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140306; cv=none; b=SgVjZ944r4i7FLzdzBXy6hgLHAIjl0kztR66ZM4+56KfJDnz5xbRgT1fdRnVdm2q9gEe3+dORm1nN9+Kyi0SI0gmLC5AMdbm0DtzyD9tdXMKbVPdwswMSOASlJwWb8N+axTe62rw0TbWiL78xlFVLLitqhL1+XNDrhYrq9h6aRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140306; c=relaxed/simple;
	bh=/k2ztJEaruSyqmYpxsM+Uu49t4dQntZi8KLnJGAUtHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIhisXEQt+2J6Me7oGPHYtUiFyoCtEWM0IWCS0+5JbD8M+ZDN5/FGRrpD7/cfpvJOPb97yQ2eDRue7ysb2cqBixbbnq/+MlwTaABu1cwmgDlJUXATJGoYsTW54IabULuchtdOGeajDYs9aTD9kdoBQgsAh9apk44Hiw9bMSC4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO0p7qoQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO0p7qoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C207A1F000C5
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 08:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792140304;
	bh=5oLOV9Qdsoxh0GHtWUnXtWx0vJk9a29gd1M7eCXLL3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VO0p7qoQACAx8Sno6HgxKbT98WfszQTtKl9uuNPGtqLxqqTOmKr0q8vg0EYVPggi7
	 9Co3R+BXkSu+phSg9DcpyXiW7Jtud7JfOa75GJOv0N0Zd0sqiVPa4h7JEY/M4Tu7fB
	 zuM3Mm/pKYrHSs8F3HWnj2yQfgx2KlTj4MFxn0qgJ28LqwgkchHUPkdzE18d/AqVMA
	 Nan3W6nhbHfCwWGz4BXcDevDQQ3SrAAf+zQeUC+Qio8ceJaOyBwmr2ElYbDJ4R9vZX
	 YNI1TfFQtmrU0FbX3K9iu5NziWJCti6Lyjzlr0xVKIeVEg6E3EDxg2WxYLjbzg+d7k
	 K0b83k/NuEatA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a75f960be3so33479231fa.2
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 01:45:04 -0700 (PDT)
X-Gm-Message-State: AFq9FYJmn6EPwmPELiiug3fzRw8QFNkSMZR3wpuPXZeKGgbosp9FBv17
	0HAHF5uGnzFD9AxFvHAXNW+GKmWSJ0zwlYYMGhIQ6tn3s7/NEIvVtlZPKgIHeqTO7E+p1iVs9tJ
	i5Wubh3FIAcNLG8h1tdzeH+jtDNRC5ZY=
X-Received: by 2002:a05:651c:211e:b0:3a1:30c4:d95 with SMTP id
 38308e7fff4ca-3a9c515d781mr54335571fa.5.1792140303319; Fri, 16 Oct 2026
 01:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
 <sashiko-outbox-172006@kernel.org>
In-Reply-To: <sashiko-outbox-172006@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 10:44:48 +0200
X-Gmail-Original-Message-ID: <CAD++jLmh9ktU8JSyXbW__GgpwGZWRKH-iStCVMctmvatTT_ZwA@mail.gmail.com>
X-Gm-Features: AclHuK9_LSfOZmC7NNYi8U-SP_8_OXT0ztxu8Nyg1s7iSlLg85lDa_6AB_RidCY
Message-ID: <CAD++jLmh9ktU8JSyXbW__GgpwGZWRKH-iStCVMctmvatTT_ZwA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: bcm7038: Add a restart callback
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sashiko,

On Thu, Oct 15, 2026 at 12:48=E2=80=AFAM <sashiko-bot@kernel.org> wrote:

> > +     /*
> > +      * Prevent runtime watchdog operations from interfering on
> > +      * uniprocessor systems where restart handlers are preemptible.
> > +      */
> > +     local_irq_save(flags);
> > +
> > +     /* Stop the timer before changing its reload value. */
> > +     bcm7038_wdt_stop(wdog);
>
> [Severity: High]
> Can this restart handler execute out of sequence with other watchdog
> operations?
>
> If a panic or SysRq interrupt preempts a ping or stop operation exactly
> between its two writes to WDT_CMD_REG, could the hardware state machine
> become corrupted?

And I felt local_irq_save() was already overzealous.

It is there for *exactly* this reason. And there is a comment
right above it explaining it in case you didn't get it.

If there is a problem on SMP systems with watchdogs
doing a keepalive to the watchdog in parallel with the
.restart() callback, that is an issue the watchdog core,
not with this driver. A lot of drivers just write into the
watchdog registers in their .restart() hooks, so if this
is a generic problem we need to fix the watchdog core,
not random driver .restart() hooks.

Yours,
Linus Walleij
