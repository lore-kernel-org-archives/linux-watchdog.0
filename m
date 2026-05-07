Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942003ACF14
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152933; cv=none; b=gCYkf/m5GwxDD6HwjRV1MTtk955Cayb6EJvBOXuXRwKkXSMPB1MCxT2J8SMP5a9oFfc1WBQQaVVhTEH6CgYEy6F4hNgrfAt4h3E/l9ZDUK92loa+4G22fKGiv89yKgNYmpFZpJH07I4SJdwQxb5U2YjD+FgTkJtanA1GnA62vvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152933; c=relaxed/simple;
	bh=6wrZY9IziN8qWO7M7Go6gONMebXh2ZZ6cInaOrkBUH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKpt/UZZcEun2Gnx1bsxC19cAJ9zmyx9Np9rUQTY5YrDndZkB2Zvo5gM2TnPtelRcCU43jPCemU94OJqzwPtI+9AWXfbSpvKrxuLLvr6NMgPNNV0HJDrMXlsNiM15NnBYtj0UAHizVOBY2lV1ds5xsoiOsEDmES781YGR5LgJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mHJDjue1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mHJDjue1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3775A1A355E;
	Thu,  7 May 2026 11:22:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B47860495;
	Thu,  7 May 2026 11:22:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C54A9102F24D0;
	Thu,  7 May 2026 13:22:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778152930; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TyVFfMB+bFVtMdTeDS+Mg+c4RXdxV+nVPBtIth66O7o=;
	b=mHJDjue13Ny6zxx3NkuAPI1Ol93kpDHpMSkO2coIizzlkFaydoNBAtF1/THfkEtWM4sMN9
	0uRK2LxMcT0E1Q3kTGQyVSSy3BneWuRRh9oPcy7WPeVVaRHPGjKJcaixLclJ2LW/5q1QbQ
	u5tWNUdFA71BI//Sk3ED4eiA4v4SqZ7ez3aVOy0EpNPW1jUs+O/PGa7LJtFcPV1pZYIWPD
	YOIZGWz3f49yOAwiGO5Ag7lYLbsZmomehby/F9i8uAmS3oSEj9K1+bjWhMZuGPAa6JiGLh
	zVqr3p2SYns2whVqjGOw7lGsI+M/EEt1ShO3RlrAhOgE2My2ow/H7Pk25HQ5gw==
Date: Thu, 7 May 2026 13:22:07 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: watchdog: renesas,rzn1-wdt:
 interrupts are not required
Message-ID: <20260507132207.5f2fdb7a@bootlin.com>
In-Reply-To: <20260507102410.43384-5-wsa+renesas@sang-engineering.com>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
	<20260507102410.43384-5-wsa+renesas@sang-engineering.com>
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

On Thu,  7 May 2026 12:24:09 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> It is now understood how the watchdog can do its job without the need of
> an interrupt. So, it is not required anymore but optional.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
