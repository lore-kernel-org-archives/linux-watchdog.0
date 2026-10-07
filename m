Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686245C71D;
	Wed,  7 Oct 2026 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365324; cv=none; b=SfizsoaQmz7jjXeK1ML5O7PTZFKM1pc788qNz6dNXJJPOwyEIGJtgliDLh/1GCGBtB75NF8L/s5jpDeIoiLoPaB5LsnEkqNrZM6ezHJ+8QsBFgzFHbklx7MwD9vUFr+AJdyQdFkwaIX2B6vyolNWU0agivEgKpJMxpRQeD/ADWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365324; c=relaxed/simple;
	bh=6/wlnyYHp3MsNQ5XGu0sam6Effzu4HllaoTNXQl7XkM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K/El6XBYJE/G6sXz/sZtCtT5483mtkOPGMnxbrUgmf5Q2RS9WyDpOBb0QICF//XwcpLoawGnahaUizcOwXm41XzChGlh45+1j7lw2gfU1TisiHJwD5o49JZff266EJoxKOWr1lMtBevQmtUxKZ+Kgg8J/Q8saCXpQgJGzwK5GeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDSIUyFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDSIUyFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9501F0089B;
	Wed,  7 Oct 2026 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791365307;
	bh=6/wlnyYHp3MsNQ5XGu0sam6Effzu4HllaoTNXQl7XkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UDSIUyFWSQlYlhfVhERwJBBlsxJvSqd4q3qdi7XK4u/V/MlFXuVevG62UnqNkygcc
	 0KUrRHea36jBJY1FDhcz6AKY3m16qF9VNG5EyNhjFaIskJmieLwW9MHnjYgNx/Grd5
	 0ujFW114qtRVLypo5TdNtwFscHk70LyBdXgh/kdGbYLeWDHwPFEIf87V9VhhJZZdN8
	 ladZWoRI+zPAEMQVq//gK2lw23vnd0tAid91KOw4lNd13k8aSh5bK9zIdIemWfCEC+
	 zJQH3m/urvo7Wzwn9B+EwEgki+FIII/5dyMMrurUHopdDdzTLIWUoQUqpUe9/+W+VE
	 7aXkPG87awW9Q==
Message-ID: <sashiko-outbox-162793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/13] mfd: nct6694: Move module type macros to
 shared header
Reply-To: sashiko-reviews@lists.linux.dev
To: a0282524688@gmail.com
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, mfd@lists.linux.dev, linux-watchdog@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-hwmon@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, lee@kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20261007092102.3768818-7-a0282524688@gmail.com>
References: <20261007092102.3768818-1-a0282524688@gmail.com>
 <20261007092102.3768818-7-a0282524688@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 09:28:26 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> From: Ming Yu <a0282524688@gmail.com>
>=20
> Each sub-device driver defines the module type used by its own
> commands. The upcoming HIF transport also needs to recognise
> NCT6694_RPT_MOD, as report accesses are served from a separate
> register space rather than through the command mailbox.
>=20
> Move all module types into the shared header so that the transports
> and the sub-device drivers use a single set of definitions.
>=20
> No functional change.
>=20
> Signed-off-by: Ming Yu <a0282524688@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007092102.3768=
818-1-a0282524688@gmail.com?part=3D6

