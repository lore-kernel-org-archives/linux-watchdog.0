Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBB36604B;
	Wed,  1 Jul 2026 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878171; cv=none; b=oXNAeiNm66QvJfwupl6FuAHW2O+A1V9brPL/82kZW0a35xI1SvPWnyc2wt0IynUMEi7rlmHmsBvYZtVVX2iOMFT3kZobkPZm4y6eiidp7bPqTAXtkhn2qAxeh1JxnnGsSpXhVjECoTWg57KBvgzhdcGD8+ZSK1PZVdKZ5Bo3sdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878171; c=relaxed/simple;
	bh=V42AFfF45yW7Jm7jlo/qFOfzYwrYr3Gz33RednS3Il0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P7cWEBLGWpbNF7BR/RlVxpec/9zrt+BPGOnp7YXTwvZwVEuA6H/AMVP+Sq2n1Z5dwuVaFsuDOnrSFfDBAbvfZTyrhu7Bu/r4s5aIX3GZRCJc6TOHDECxM3+dM7lpR8v1roa/o8iLFCuqPYgmaPEVvkI7Eida7QUgUd18UALV/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En1Qet40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En1Qet40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388941F000E9;
	Wed,  1 Jul 2026 03:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878167;
	bh=V42AFfF45yW7Jm7jlo/qFOfzYwrYr3Gz33RednS3Il0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=En1Qet40doNOOqEFLxyMsNua1dtr3129A/21xhuq/V5smNix47YnQNP/ChJECtKhv
	 y+GZLNz86v1mgIpVbNd6M3kWPrTztBmvldiysmRiDrySDb+U9AiKPcW2eCv9Z9adds
	 Gtdd9DfeB7X3mq1DiHW5iCynfgMyqIgM7jQwfrmje8XpV3Q3AG3O2Dtuzwds39XJ9h
	 YkWtKMt0N6ZACX86Jv2cfvpVR1aRDVMxXnvpVf0h2GO0bh/rBQS/Y2aSEKn7Hxl8AZ
	 pL6gh6k+XK7wgyyaVLebmjwf3LmhTuI3MBikA9yKLuCC+Jk1UDIGZrN1l5enjnqDfR
	 rcgsCMzaeV1wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/7] mfd: nct6694: Move module type macros to shared
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: a0282524688@gmail.com
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-hwmon@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-watchdog@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260701035025.3082927-2-a0282524688@gmail.com>
References: <20260701035025.3082927-1-a0282524688@gmail.com>
 <20260701035025.3082927-2-a0282524688@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 03:56:06 +0000
Message-Id: <20260701035607.388941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> From: Ming Yu <a0282524688@gmail.com>
>=20
> Move NCT6694_XXX_MOD macro definitions from individual sub-device
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035025.3082=
927-1-a0282524688@gmail.com?part=3D1

