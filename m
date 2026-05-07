Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329863C3BF5
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152868; cv=none; b=Rzq2lG19kG8TXE4rPKjHNBq43h1WxvumEqgjS/Sik0SbsBfSKhR3TQ9Q2iRXiZHj4n+z9Eq25d2JvThMEZvz/vNsSJXHGR3lXlI/dgketjNf2Re9ddphPv43R4CkwSisNZ0tkbAkRfUAQjoPOTT8W8937IFQSUiG3rNMg/x/XKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152868; c=relaxed/simple;
	bh=k3w3Wg4hhYKzm2ajlCQugTngqghBsE21BpT/F90KZr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYJxokkIsY0DMMQSRfVOhXVPL9UELMZ+B08OVpjWMQWUV0BrHlQl27yrRNWCsImIjpMaumDW9h1n+E6h8T0AJgu8k1B6Kr0o3LgwyLmDwtGN6KnMhsA8DnBSzuUyUAyrGhr8wsBch93i/CDZ8yPhPWf3tSFyWhiMhRJgTKf14p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gx0edOfG; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gx0edOfG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A9314C5DC60;
	Thu,  7 May 2026 11:21:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB85B60495;
	Thu,  7 May 2026 11:21:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C96EC107F2329;
	Thu,  7 May 2026 13:20:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778152860; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aOLysT8Z8y7OfYfpXXoyJQ4LwrS6dTwQ8oR1aY1rOIE=;
	b=Gx0edOfGF5ZRmePWCrjxbAa5P8sGxCQ2//lD3uDdvikDF+Nkw2RCNaBZax4skIsYCx4qSd
	iqmezGwKRr8i+Q5ctJ2Q/olOLRPQCXYG4gVDIhlxePs+cdMORUnHVyMQo2RjCKBDI81khT
	N1QzKLQKpoU0zsHM+wdu6EoL1gTv7C2gs+21O+IQpsfeOKohdniYZdMQXPf0dUf4ReKyUL
	9fSs0qpic/TV3hKPaK7rUrQq8wFwGwykgvOFWFsAszhw2s1XgHaPP47oFwZBiV0PP7QDR3
	4kAEc4/ir0WMBwcIG/u0i0d/nFTJfQ9F6KhqGYfI5g469Io8h6WYyY0w2WGLJQ==
Date: Thu, 7 May 2026 13:20:57 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 3/4] watchdog: rzn1: remove now obsolete interrupt
 support
Message-ID: <20260507132057.19e86962@bootlin.com>
In-Reply-To: <20260507102410.43384-4-wsa+renesas@sang-engineering.com>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
	<20260507102410.43384-4-wsa+renesas@sang-engineering.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Wolfram,

On Thu,  7 May 2026 12:24:08 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Previously, it was overlooked that the watchdog could reset the system
> directly. So, a workaround using the interrupt which called
> emergency_restart() was implemented. We now configure the controller
> when booting properly to allow watchdog resets directly. Thus, remove
> the interrupt workaround.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/rzn1_wdt.c | 19 -------------------
>  1 file changed, 19 deletions(-)

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
