Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6F3161A3
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777950720; cv=none; b=n+Q4stZ9BsEJxD5XUp4NBnqDpI7wbXoDglg1HfDWl91oMHgG+tb79IDNUk0XlXTMTrsFclCnIJ/vf00GQ59RhYDgjKJAkyTxl43to0RJTSPVgHqYIk0Cgy2B/Y+qfc7YRTkEGeog7msqEYJm3S3ENsmyX0OD/a+GGDY6YPVduU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777950720; c=relaxed/simple;
	bh=jekjxa6Di6506k1y+2Yx1q5Rd9J2eUpG1FzPRNflnVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dk8q+elT6T9Gi9+ysjVqdBQcLM/U0N5hCO/4G2XfNZILqccMHLBSgFmKqnmTGI0MO2b1/S29aXijHP022y5C2fuKsWeqjTjMiwCQsoYf3yIS1+E1VUtr3NBNBhAKgxy1QOuDqS2XkAIerTG0AphXBW8hTKkxA7sG9hrwZwamqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNsD3TCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNsD3TCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76950C2BCB8;
	Tue,  5 May 2026 03:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777950720;
	bh=jekjxa6Di6506k1y+2Yx1q5Rd9J2eUpG1FzPRNflnVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iNsD3TCwbgICwGL72L4Wia07zJrRd06lUQxd1b7JiL2CCt2EXRAJhj0S6YVi4HkOx
	 DfDQfNUclq3LCwLBeL9X5uFFrKrQeWXfV01r1ool1sLqI6NOFvtIUCEpu1aIsTnHd1
	 IK3PgDsfazPkD6a3yH3yrS1dKH1bKm//NpA17EMfl5jMamFK++2EYFUBE64/CDvQzw
	 ddzmW9QH9t1kJCMD+h9AX2Qo/gN1toXaJ8/98nYzTzPCjy6lL3ZHgNsQE95ABKFEnB
	 Z47cKtXDVCs9czdnMchvMBk11kdgbYIy+nBLu3bUJr7zJOCVQ8DUD3G1dsRVn1Is3e
	 wJQeyiZzxTDYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: remove drivers for discrete ISA WDT cards
Reply-To: sashiko@lists.linux.dev
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260505023007.58175-1-enelsonmoore@gmail.com>
References: <20260505023007.58175-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 03:11:59 +0000
Message-Id: <20260505031200.76950C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete cleanup of removed ISA watchdog drivers (stale documenta=
tion).
--

commit c15c9debaf78e0e06a920a66f6ec58e1cd3c2f62
Author: Ethan Nelson-Moore <enelsonmoore@gmail.com>

watchdog: remove drivers for discrete ISA WDT cards

This commit removes the mixcomwd, pcwd, and wdt drivers that support
obsolete discrete ISA watchdog cards.

>     The mixcomwd, pcwd, and wdt (how generic!) drivers support discrete I=
SA
>     watchdog cards. The wdt driver in particular does not support
>     autoprobing and requires manual specification of the I/O port and IRQ
>     the card uses. A WDT is integrated into many modern chipsets and Super
>     I/O chips. Embedded boards using a WDT, even ones with ISA slots, are
>     unlikely to do so via a discrete ISA card due to the amount of space
>     required. Given these factors, it is highly unlikely anyone is using
>     these drivers. Remove them.

Does this code removal also need to clean up the corresponding documentatio=
n?

It looks like the commit removes the mixcomwd, pcwd, and wdt drivers, but
leaves their documentation intact:

- Documentation/watchdog/pcwd-watchdog.rst explicitly documents the removed
  pcwd ISA driver.
- Documentation/watchdog/wdt.rst provides obsolete boot parameter examples
  (wdt.io and wdt.irq) for the removed wdt driver.
- Documentation/watchdog/watchdog-parameters.rst contains stale module
  parameter entries for the removed mixcomwd driver.
- Documentation/watchdog/index.rst still includes links to the orphaned
  files in its toctree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505023007.5817=
5-1-enelsonmoore@gmail.com?part=3D1
