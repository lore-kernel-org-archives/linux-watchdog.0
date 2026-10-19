Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440773;
	b=UGpg+ap1RBg2tf/hzRE7sRBSgpOI6KZT6MSvAdHlRCwoCgMezcf7ZPPrILXpUTfDxeGl
	 Ms4d8F01786Zaim3d4NGWuMaEbFIJzaEc0PFuliUzAmkX9cMa6ES79GrX0VbbRIeHhowj
	 JdUZRuWDPxiTS88k6+HqGG20xuiwysAzvaIV1vZFb5HycvrYjsc7zNvpPau1U3XTjMFrw
	 0UNNz9D2u8lOq1y59A0sSuRJqp6LyuuPDmFH27pK/RHJspg2GheATxNGQdj3cYa93drCh
	 VyAqIO2bnyq9+r/8AsZ71zbspU4QbjdXWsomK9oq0ywBKlAlJEvPrSQyVhUXd8mBmLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440773;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=bhtdHmlzv0DKoEw+Zc7TOwdDACTcoyGMeQ8adip2B7w=;
	b=b120swheyUfF9NFx9UEsvX86l+8JJZ6OzO8wg8NiR02Rq7NuHhxZNArG9uUXGnTKMyzM
	 4ENYoC3AFg70P1y6D9zt8jhyACUzRCgCB6L3BYutm3HMTf3/p0D93DHX3ZGWuGS2w8aye
	 y4m7s7xj0MXE8I+epIB//M9seRaIibNy1a6qJOyN4YOhDP1cZkXey/ueF3Prvd3VX6Fag
	 OEhChtDvuoqV/+QvBEO8kwfBep5xcs7yAivRuWHbNpoyt5AiEuuY0Nc2pFVjlKDobW80k
	 i9WxYFlSzNQv6iWm/vQQcOTPYXJ3lBV7sbQyNpJFpxL1ptrdGFUx7N8gnvioCPBD/PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="Pa3/iQqA";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F45606A31A;
	Mon, 19 Oct 2026 20:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F45606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Pa3/iQqA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EB2E7C5CD5C;
	Mon, 19 Oct 2026 20:13:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B800F60582;
	Mon, 19 Oct 2026 20:12:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A795910328C52;
	Mon, 19 Oct 2026 22:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792440766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bhtdHmlzv0DKoEw+Zc7TOwdDACTcoyGMeQ8adip2B7w=;
	b=Pa3/iQqA6vAUfEWx2TIhJVrvDVY1bNti3mgE+dD437CyxrCLMqTJ1ErML4wYetDTmcOhYK
	PGq7h9FpP9dgS6Ncnd/AkqwJYFSPAxzZpb4yCCAjWY741cXlg2eGwlHYPABmg57+gc+sf9
	MbVZ5UeAITIRMWz1Eh3/oQAh6vsciD1LpJEyq2XrUfqG5VY2iX+lZm5FyMaQrAOn06ueNZ
	gi26YmOton3sKCyOeJXz0LOqt71W7hYVDciazQm48/qe7tvcsRlzC/6olMpGP/ez9o+f2V
	tcsQpXF00uQ0CStVQxb/29i3zXwo+y347qLAYTuhPpZg18W8E8lWlZjzlv/mqw==
Date: Mon, 19 Oct 2026 22:12:44 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Pablo Mazzini <pmazzini@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/11] ARM: sunxi: add Allwinner B288 and the
 PocketBook Verse
Message-ID: <179244056617.104236.5769731153552958433.b4-ty@b4>
References: <20261012100816.331033-1-pmazzini@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012100816.331033-1-pmazzini@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 12 Oct 2026 11:08:05 +0100, Pablo Mazzini wrote:
> The Allwinner B288 (sun8iw10p1) is a dual Cortex-A7 SoC used in e-book
> readers. This series adds the CCU and pin controller drivers, the RTC,
> I2C, NMI and watchdog compatibles, the SoC .dtsi, and one board: the
> PocketBook Verse (PB629), a 6" reader.
> 
> The B288 is closest to the A64: most of its PLLs are bit-identical.
> The clock and pin descriptions come from Allwinner's BSP, cross-checked
> against ccu-sun50i-a64.c. Tested on a PB629, boots to userspace.
> 
> [...]

Applied, thanks!

[05/11] dt-bindings: rtc: sun6i-a31: add Allwinner B288
        https://git.kernel.org/abelloni/c/51f30cb855f0
[06/11] rtc: sun6i: add Allwinner B288 compatible
        https://git.kernel.org/abelloni/c/3784706c87c2

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
