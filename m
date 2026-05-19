Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605983537EB
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217247; cv=none; b=UsT0yAvqPD5GrRpb5LTG8HJROXaCk3CM6dcYYGnf3l3PxUNiwLMR/bkeVH6v5akt5U2scTn658zTgwwhTfDPI46l1lc+ipLd6BH48dki434xZGkkps+7Hczw+i3X7FqGf38SJm+2/uu/1Foh2LR4J60OoSHEIF4/RBkXniy+6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217247; c=relaxed/simple;
	bh=VUXdjIDNxw6nng5+Cxf5s/uJiUgdxq2R6eGJqvzRxMY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eXk3hpOA8wIRRHNZ0JRQpeX8iMRZQloYMyVVPuDnyKtvUBJhXS/dCEs9GGhl4ePd08e79G0w6M+pQ35v/A7I8vCL0zkW3fadGX/EP20vevuRZ+DfPqfa5rqTXmk0FNJ9PwNDA5xRI3gNW3k2L8trrejWZ1zvyyHAxQFVFQu50eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=SPtOoppo; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="SPtOoppo"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id D500678546C;
	Tue, 19 May 2026 21:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1779217238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJW4rKp4Biu70s4rOupBMs9U/fgxRUse6nvk0AKCAL0=;
	b=SPtOoppoSKKCSQ7eZp0bwx9IgBCfPwt4mwKGH5NZlcvRcWKlYsNUKzxHSy6Ye0E3jRKg0s
	DENDSj4RImZSYBZTGfytSFVF9DsyejPsnpYvsDrnva4at7oIzs/AwK/SXOL9YUKc459ArG
	WoZEEwsi87AVzMYT++DjJ55rVV2aOvQXSDcjYyVCTturtwR+XbxJIF5MdaCf3+RpkExFgl
	IyEpvD8XkJjv4c18UidyxTWwBN8DJ57P76dW79vk+rKG5RdBnUM9vSlUKzQ104sp998mMU
	IFGYvBaf4kjJxJOWYrPvvkhYsHWqm8DGLcRT5TJzuBHryzylZKV3yGjg51+qAg==
Message-ID: <6ff773c9cf93167fbfcf5d9a40106121f9ac8238.camel@svanheule.net>
Subject: Re: [PATCH v2 1/1] watchdog: realtek-otto: Change to use regmap API
From: Sander Vanheule <sander@svanheule.net>
To: Rustam Adilov <adilov@disroot.org>, Wim Van Sebroeck
	 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 19 May 2026 21:00:37 +0200
In-Reply-To: <20260519182329.24472-2-adilov@disroot.org>
References: <20260519182329.24472-1-adilov@disroot.org>
	 <20260519182329.24472-2-adilov@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rustam,

On Tue, 2026-05-19 at 23:23 +0500, Rustam Adilov wrote:
[...]
> @@ -74,24 +75,17 @@ struct otto_wdt_ctrl {
> =C2=A0static int otto_wdt_start(struct watchdog_device *wdev)
> =C2=A0{
> =C2=A0	struct otto_wdt_ctrl *ctrl =3D watchdog_get_drvdata(wdev);
> -	u32 v;
> -
> -	v =3D ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
> -	v |=3D OTTO_WDT_CTRL_ENABLE;
> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
> =C2=A0
> +	regmap_set_bits(ctrl->regmap, OTTO_WDT_REG_CTRL,
> OTTO_WDT_CTRL_ENABLE);
> =C2=A0	return 0;

iowrite32() doesn't return anything, but regmap_set_bits() does.

You can turn this into
    return regmap_set_bits(...);

> =C2=A0}
> =C2=A0
> =C2=A0static int otto_wdt_stop(struct watchdog_device *wdev)
> =C2=A0{
> =C2=A0	struct otto_wdt_ctrl *ctrl =3D watchdog_get_drvdata(wdev);
> -	u32 v;
> -
> -	v =3D ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
> -	v &=3D ~OTTO_WDT_CTRL_ENABLE;
> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
> =C2=A0
> +	regmap_clear_bits(ctrl->regmap, OTTO_WDT_REG_CTRL,
> +			=C2=A0 OTTO_WDT_CTRL_ENABLE);
> =C2=A0	return 0;

Same as above.
This is probably short enough to keep is on one line? (< 100 characters)

> =C2=A0}
> =C2=A0
> @@ -99,8 +93,7 @@ static int otto_wdt_ping(struct watchdog_device *wdev)
> =C2=A0{
> =C2=A0	struct otto_wdt_ctrl *ctrl =3D watchdog_get_drvdata(wdev);
> =C2=A0
> -	iowrite32(OTTO_WDT_CNTR_PING, ctrl->base + OTTO_WDT_REG_CNTR);
> -
> +	regmap_write(ctrl->regmap, OTTO_WDT_REG_CNTR, OTTO_WDT_CNTR_PING);
> =C2=A0	return 0;

Same as above.

> =C2=A0}
> =C2=A0
> @@ -126,7 +119,7 @@ static int otto_wdt_determine_timeouts(struct
> watchdog_device *wdev, unsigned in
> =C2=A0	unsigned int total_ticks;
> =C2=A0	unsigned int prescale;
> =C2=A0	unsigned int tick_ms;
> -	u32 v;
> +	u32 mask, val;
> =C2=A0
> =C2=A0	do {
> =C2=A0		prescale =3D prescale_next;
> @@ -142,14 +135,11 @@ static int otto_wdt_determine_timeouts(struct
> watchdog_device *wdev, unsigned in
> =C2=A0	} while (phase1_ticks > OTTO_WDT_PHASE_TICKS_MAX
> =C2=A0		|| phase2_ticks > OTTO_WDT_PHASE_TICKS_MAX);
> =C2=A0
> -	v =3D ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
> -
> -	v &=3D ~(OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 |
> OTTO_WDT_CTRL_PHASE2);
> -	v |=3D FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
> -	v |=3D FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
> -	v |=3D FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
> -
> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
> +	mask =3D OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 |
> OTTO_WDT_CTRL_PHASE2;
> +	val =3D FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
> +	val |=3D FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
> +	val |=3D FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
> +	regmap_update_bits(ctrl->regmap, OTTO_WDT_REG_CTRL, mask, val);

To be consistent, you would also need to propagate the result of
regmap_update_bits() if it's an error. Same for the other regmap_*() calls.


Best,
Sander
