Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F13612ED;
	Fri, 21 Aug 2026 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283952; cv=none; b=m8rqfh0OmAvmoD+1wEvZ2w5f8hF02E7XLEy22Oiy/jeKee88m/XcOuikswh6qeG6Y9yL/tm7C+rLxgF/F+FmL7QNlUxBqnaF9GEbCuxkSudCtmC22+KYdxRpZNfLKZl6qkNdHXxbIyqiaYUqnHKmPVVjzMXhlWCPcMJdqhNxANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283952; c=relaxed/simple;
	bh=0Vydrt3ssMF7WVBka/76aNk8/QWPspNQVrPsn9wKnUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HmaOvGWgxs+LizGo/NZyyZO/74BMnCsOjCOzrfm5hELn7H8YGYVDZQb6ZfKVazzIZYmTTATLnlDJLKbrcykPjaetvtPC6PwWniiet3seFUzieGBMNd7niEEh+lopBZ5lhVzWMVdGVd1I+8T421KmvJXfZKeYhfx70qpOs2ktAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+ektRG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+ektRG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FDD1F00A3A;
	Fri, 21 Aug 2026 03:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787283951;
	bh=pnHNL/K5OV3I+LBVvnHcJhb+X7M7xDnIDuy7LRzAooQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+ektRG3HRUo/AtCh5nFdXi9yhlhJzqOHapzTPIb7UZ0KNDtmeZ2XznSS1YLV0UQI
	 jvEAuu93yP3hwxvPGDSnRp+lMBpfP54VHhdouNSYkDREh05sKW/Po1A23AlsIC+FBj
	 FhEk0gRNonRd9V61YXUMaX4nY0sbND9xe00A6luxDageDmoxGsl5iJH/nQBYAIaAqg
	 l3NTSZhVrPBFHi5tchJ+BPqL5H4ao9cfDjU0ezSYAJIPgE5nPwv3+CZknbT1G8qNQ3
	 RCWNDTgMHEQLBKtSVbICk4Q5U8Pt6crXdXMjOQekJN5UGqUGxD6R8ytf4oqixBzlaB
	 IQU7anY6cFhUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] mfd: nct6694: Move module type macros to
 shared header
Reply-To: sashiko-reviews@lists.linux.dev
To: a0282524688@gmail.com
Cc: linux-watchdog@vger.kernel.org, lee@kernel.org, linux-hwmon@vger.kernel.org, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, mfd@lists.linux.dev, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260821033505.4017901-2-a0282524688@gmail.com>
References: <20260821033505.4017901-1-a0282524688@gmail.com>
 <20260821033505.4017901-2-a0282524688@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 03:45:50 +0000
Message-Id: <20260821034550.D9FDD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Moving driver-specific macros into a global header that facilita=
tes bespoke parent-child accessors.
--

--- Patch [1]: [PATCH v7 01/10] mfd: nct6694: Move module type macros to sh=
ared header ---
commit ddd165427cd793b4dafe2d040a37ea0bf7d0d5fc
Author: Ming Yu <a0282524688@gmail.com>

mfd: nct6694: Move module type macros to shared header

This commit moves module type macros from individual sub-device drivers int=
o the
global MFD header include/linux/mfd/nct6694.h. The commit message states th=
is
is a prerequisite for supporting multiple transport interfaces without
duplicating these definitions.

> This is a prerequisite for supporting multiple transport interfaces
> (USB, HIF) without duplicating these definitions.

[Severity: Medium]
Is it accurate that multiple transport interfaces use these definitions?

Since these module ID macros appear to be used exclusively by their respect=
ive
child drivers, shouldn't they remain local to those drivers rather than bei=
ng
centralized to prevent duplicated definitions?

[ ... ]

> diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
> index 6eb9be2cd4a01..3c683e317aa32 100644
> --- a/include/linux/mfd/nct6694.h
> +++ b/include/linux/mfd/nct6694.h
> @@ -8,6 +8,15 @@
>  #ifndef __MFD_NCT6694_H
>  #define __MFD_NCT6694_H
> =20
> +#define NCT6694_HWMON_MOD	0x00
> +#define NCT6694_PWM_MOD		0x01
> +#define NCT6694_I2C_MOD		0x03
> +#define NCT6694_CANFD_MOD	0x05
> +#define NCT6694_WDT_MOD		0x07
> +#define NCT6694_RTC_MOD		0x08
> +#define NCT6694_RPT_MOD		0xFF
> +#define NCT6694_GPIO_MOD	NCT6694_RPT_MOD

[Severity: Medium]
Does centralizing these macros here violate the MFD subsystem guidelines?

The guidelines state that driver-specific definitions should not be placed =
in
the global include/linux/mfd/ directory if they are only used by the parent
and its immediate children. Keeping them local to drivers/mfd/ or the
individual sub-devices is preferred.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821033505.4017=
901-1-a0282524688@gmail.com?part=3D1
