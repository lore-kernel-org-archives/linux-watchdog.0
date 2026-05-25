Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C3A3CFF6A;
	Mon, 25 May 2026 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697513; cv=none; b=FwfKN9U36eAzzVyy/3BvSHEnv0R7AsQKnE6LJy2YqvECPWKyEng7tGSIPny3O0/Y3DF7OGJbv5QL/fkv/b3ic7vi2htFMMONkvfQeduhRXxD/AVK1VABawthdosf8ZFh1qhGKc4VqmiTnAbI8IEdsgJqpzIKA9Ayr+1SLPDX7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697513; c=relaxed/simple;
	bh=qK02sUtQCrBIbwZTzE/imEPtQVrAmD3WRrd6V3LryuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHsqA9UfsVgxWZB9/n/mSfrscwMNkI1NucfBe5WmGW7+foD+sM2D8Frgr9WZqblKV3V/WIm16S1vtobO32o0iquNPhf0G75WibQicVol37x8PQ4Y2Mg260f8TC8Y3pEGI7yoTruk2gmR3ptByeGBw/J7kw3pjBrd3mWeOindzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrhr4FHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrhr4FHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F61F1F000E9;
	Mon, 25 May 2026 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779697512;
	bh=NVJkDmmbZtEPk+Kqj4uE12KrfyY9Vb1oAXv6AbMWW1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rrhr4FHcA8DM5W9misj6s18CLnIev4M/mZVmBWmd69HVtoABmtEzEGjmm1BsfRH6H
	 dL81ujhGgs582+q2EapxrG6MY5gnKdsAaen+lv6fsQ9hHJApn8hOCOEbQrAhCg7g//
	 kRZYFJ88Yx9rTKYWVNoJlBqZT3dkLqvnBslpphByxAgrJ0zB0ocdqijXrwbFzr5Vkc
	 X3QGeq1Ag6kp/JlqNS9ItMtrV67MwQdtfNv28IC4pixTerJRsEI2I/ShgjUCzPRweB
	 9F6/QovZ3qH98MSOltXVTHPRh9lEtkoesqfKRxZ8wkQ+8COJF0V6DPjxNU4YxW9bXb
	 IOFEZ2w+rvrTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] mfd: nct6694: Move module type macros to shared
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: a0282524688@gmail.com
Cc: linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260525081736.2904310-2-a0282524688@gmail.com>
References: <20260525081736.2904310-2-a0282524688@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 08:25:12 +0000
Message-Id: <20260525082512.9F61F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> From: Ming Yu <a0282524688@gmail.com>
>=20
> Move NCT6694_XXX_MOD  macro definitions from individual sub-device
> drivers into the shared header include/linux/mfd/nct6694.h.
>=20
> This is a prerequisite for supporting multiple transport interfaces
> (USB, HIF) without duplicating these definitions.
>=20
> No functional change.
>=20
> Signed-off-by: Ming Yu <a0282524688@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525081736.2904=
310-1-a0282524688@gmail.com?part=3D1

