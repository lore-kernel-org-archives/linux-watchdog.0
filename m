Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379215;
	b=KGFPFldIsqkKmCZlQBLO5UOXo65jzrhV+m4MfSP+f1hHolo/ttHWk1HYt0S+u9LATpf8
	 b0oABYSAhQxxYw+yuowacKGNxGQCsuwa1GkqeFoE9eLjK7VzGFy1KW0q5I81iYJnzHIgq
	 0tFC9r1b0asg+8rfim7IkP8PYk7IY6wdQIRUtrQELbtAqQ7PyvfrIZE6jacAtJ+4JMsN/
	 Au37aisqUOqOrIlTBtSexU9y2EJ88S/NXBlHxmW1hdv768dQecprUaEY/mw6qHeiIGX7j
	 9HPzaXjqWRgBb6kKGKSfBiJAOEJBJEfSXvn71SMfKMqLvotxmx6rqIYYJ3ZW7UxmXBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mxG9O0TEMRCC+T6pN1tClImWrUfWD0HTBBmwl/Wy/fA=;
	b=5MvDkihWJ0yGvNhTb5bY5cDf86BcIuQJZ8O7VGc74UhViODu3YSpNLC1Z3ogDwUUSUlk
	 N2wKZdgWuKG/tF1B73HADC0eKMAuNY/ohxaT41Hzooit7G0vc+88YG/xIuxiKAPynGkiI
	 TtACwFOLALUYVyKb30Fkxu8chpVCismZINQSWlnx5/4yPHOqjLUrAvtRNVH4fZbAFdaQY
	 /mPvZGYyFj4qs1m4AMwmesDWpmD9tEc7ZlHI+vnzPv3rbv3B2jqI98SzJF1fKeyXKEcBA
	 CRZGJ90lsBtYg/N4ojTVSwdxqBZSqJqY19DjCLsJm3i5vcXRSw/OrBZGatU/BR4IkBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5xRm6u8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D22606A31A
	for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5xRm6u8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85171F000C1;
	Fri, 30 Oct 2026 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793379214;
	bh=mxG9O0TEMRCC+T6pN1tClImWrUfWD0HTBBmwl/Wy/fA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5xRm6u8rDiHw+RGsUp5g+TrdgNK5w3ZDOeDTW2gP2QROvPE1UQ3VQ9D9RzOiWEfO
	 p/ErgIMl+daFCXapdpThFSwhLl0PcII350wIfKwvH9x3kDK7yRw9nuDcYfJuVYZA5G
	 1FVMEzRVcTc8SQe4tVRIK/YzYY6GhF1hMIppGKAegBTHtfwcpx7EqLbPTqGF7UaCzq
	 XRV213mp4vVEtK5SEDuQZ4r+JINMeuAk3mxhE6szB+E/94UgC5fJy9r9Xe84dmpGyS
	 ojRsNG5wAO8CBIeFC0m4ST42T0Paj9wwM4o0OHcO6kE/RnjFnN+Phj1usEHLjRXEDr
	 NrOD9024uxuDw==
Message-ID: <sashiko-outbox-191287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] MIPS: mm/c-octeon: fix missing function prototype
 warnings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261030164657.2808262-2-rdunlap@infradead.org>
References: <20261030164657.2808262-1-rdunlap@infradead.org>
 <20261030164657.2808262-2-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 16:53:34 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] MIPS: mm/c-octeon: missing prototypes for cache_parity_error_oct=
eon_*()
--

commit 710759b5db134c7d9627997d6bd1fbab4fe6465b
Author: Randy Dunlap <rdunlap@infradead.org>

MIPS: mm/c-octeon: fix missing function prototype warnings

This commit adds missing cache error notifier prototypes to asm/r4kcache.h =
and
removes local extern declarations from drivers/edac/octeon_edac-pc.c to add=
ress
-Wmissing-prototypes warnings.

> diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4k=
cache.h
> index da1cd1bbdbc5d..8c36d228075f3 100644
> --- a/arch/mips/include/asm/r4kcache.h
> +++ b/arch/mips/include/asm/r4kcache.h
> @@ -31,6 +31,9 @@ extern int mips_sc_init(void);
>  extern void (*r4k_blast_dcache)(void);
>  extern void (*r4k_blast_icache)(void);
> =20
> +extern int register_co_cache_error_notifier(struct notifier_block *nb);
> +extern int unregister_co_cache_error_notifier(struct notifier_block *nb);

[Severity: Medium]
The commit message lists four -Wmissing-prototypes warnings in
arch/mips/mm/c-octeon.c that this change aims to eliminate:

  register_co_cache_error_notifier()
  unregister_co_cache_error_notifier()
  cache_parity_error_octeon_recoverable()
  cache_parity_error_octeon_non_recoverable()

However, asm/r4kcache.h only adds prototypes for
register_co_cache_error_notifier() and unregister_co_cache_error_notifier().

In arch/mips/mm/c-octeon.c, cache_parity_error_octeon_recoverable() and
cache_parity_error_octeon_non_recoverable() are non-static functions called
from assembly in arch/mips/mm/cex-oct.S:

  asmlinkage void cache_parity_error_octeon_recoverable(void)
  {
          co_cache_error_call_notifiers(0);
  }

  asmlinkage void cache_parity_error_octeon_non_recoverable(void)
  {
          co_cache_error_call_notifiers(1);
          panic("Can't handle cache error: nested exception");
  }

Should prototypes for cache_parity_error_octeon_recoverable() and
cache_parity_error_octeon_non_recoverable() also be added here so those two
warnings are resolved as described in the changelog?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030164657.2808=
262-1-rdunlap@infradead.org?part=3D1
