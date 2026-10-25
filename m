Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792953178;
	b=dWJjVUQ2EpOg6VrKncGp/g5pAT8IczCFsF4H0FnyJao2cnpYDsGeYpiv5PDNlCcVPEC/
	 7kDlciFG7FGBXK8l5XPPFzkiA46gTqomL29RLB2xJ/HaMvjmiLdJtLpvQPIs/WZ76kSCC
	 3NOLjrDrx8uLgLbt0SmAW2z9hMv8qqrQIg+xjoIkBKVoNFgw1B1v4pvgKT8LbQtLcDhRG
	 oQQXYnveVrJ/UXjGyDI/Qz2P+LETG5WX88apL5JQjJMNkoQeOMLDiHdPf7J1AmU27jT5x
	 W76ZB2S5UzDhm6XG9++f735QNktJi/R2ltN4glC3UbbTOFEgKMFNy0gGWp0TIK+v/Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cHnV8YcGeqlxYOjKsLG51tneNJM+mDCweNekVpvy4Xk=;
	b=ysI2RmrJ0gTWXtKypms/XiMihSTG1y76fgH7v0ZtgCAC/L6nO93Vis51+pADDYkBQDPP
	 SjMf1y3/7qWadqxsO24LRnisal599PNQSsRxLoJri/AWEt3/tXEhfXv8s7Rfh7d3/7LGm
	 NLv0aHFdyO9ntyCT+mViiZeoLgUeQxis6668T0JzAeRdpbJyIo5OqQHsBxpX/4Daebsdr
	 Ug2GEZML0g1TKAzRFzn9TJH28vwYaPpyL04PQPTpVKJqfiEcqMXrAJ3sO49nGuIebAkU6
	 Kcf8KYLBzk16+55tX8vxWWXtW63zdf3LFY82q6cUJTs7DcCCNt+dk3Z+ZSc+MGdicEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TkdaEY20;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F76606A324
	for <linux-watchdog@vger.kernel.org>; Sun, 25 Oct 2026 18:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F76606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TkdaEY20
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4395d31228so345320866b.1
        for <linux-watchdog@vger.kernel.org>; Sun, 25 Oct 2026 11:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792953176; cv=none;
        d=google.com; s=arc-20260327;
        b=szG4rrC9tmQdvpUXetkSmVALxNKQnYGaCK5LD8dOUImkY1TBiP47oKG3zge2m9MFrU
         O7BQsbcgagXjtYW5NsomLf7K3XxZSsf1LqwNFPCuS3WS89G1vhFw9GX18hG/avN0mbeP
         HRtWdkUko9UcvVVRYYKpJOyYQlke0LS3kAloUGtYAmuGDBdcLWvhSeSwJNl5VZR4g3Sm
         CfoLUAdJF1N2L0EMFIiOSuDzcRoVgxoHoiH2IUtLjmCMC82jrJDLDjwmI3HuB9iFTtu9
         R30FKQbjrekvJZHI9l64BggP4YbynvVs2EPQU8bge7zILy8hTuPPF8dJEl2pH7qdyV6t
         EemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHnV8YcGeqlxYOjKsLG51tneNJM+mDCweNekVpvy4Xk=;
        fh=LjEgEBPhdbZ42rJQjHYe4yruC/dI2QpV8bv2TnevfW0=;
        b=eCFvyaGmYTAg/WvDIe8m3s+p3nW46Ml9O5T37xVlzUcGpacE1JEqBVh723ZCcif+3K
         K12Rr7x4URQ8WJsjd2mOiqUZ9oJrm7JuxAIIKazz0Iw2c89aXf3MlaOHeCoZbGEaAAd/
         Rs9N0qobQaeYK24vfoDRwe6NmmGqTlCiQ3xswfZVFGLwyBt1wjFV5jwLwonbURxOAx7E
         pncBP1ah4A6N4CYFrVQ2t1JrxDLxdTMvVvqDjrmU4ghjXVbgYQMQCgC1ARNcGxTZZyni
         BJJ9yc0qhXEuwg6ovJ46S2DPAJMb0IfW/zlu8SIa6y1yyE1See3K8/Moh9WJt1ZOgwr3
         8OQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792953176; x=1793557976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHnV8YcGeqlxYOjKsLG51tneNJM+mDCweNekVpvy4Xk=;
        b=TkdaEY20As3ISZFDUG5YHBlqBF3FD75KBS8Dw858E6znrd6AL1k95VE6R6Q7HZbfF9
         DSKPFslUfFhTEwjGkHSPM+NwsZ7PabiuQFPNbz5eDr5SDdGluFzGFaqNf5UrnX7ZPQsn
         NxbWVh9zz5bIm/D2JNv5HkbXCjKdAZBdKqxenB1EDCU3AiIBoeO1uFvfv3hTMRaIsIjf
         uhUNjUKHrySYnSdvjDzoLkhTPsBhO0nwL+AdZ2uSgfSeTAngUhF7SMr3zF+bKZzhxWPj
         jbHDz6FVt0FUMDdGj/KW5gAkwdwADbmz2u/WLu0F8X91yfbkYQlLTivMSmAIwoDLfEwr
         FvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792953176; x=1793557976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHnV8YcGeqlxYOjKsLG51tneNJM+mDCweNekVpvy4Xk=;
        b=Bd+u0BQGsrmu99fZ7R07K3rxLWQxaQDgIIcO39Ts8jf5aXz3pu4CMOM8gtrWrXU5tT
         kOpt4+uHAm8mh/VHRhbPQLU30v8SvTuL5kp71Z4rucXNPP22yrMWLoKaRfkShSRBZIX1
         w6MzUFlpyNpdM7D4qoghVhtq73663Y+zCkRyDE97KsXuKLO9ypyAFQWyfQsQPxFaUSJu
         8NQ1Wd3weSDE+Ie9vzx7xpcRNPQWIM0JYKnfUeYOQblnnHYM090LvlLdKcmWrO6b7a7H
         XvsPFXDSmlrxOrT8orzi8w568WhqieS98HmQqgOhbF55iwSzaWAMkIrZ1KMT4eRYFMzT
         SbIg==
X-Forwarded-Encrypted: i=1; AKwUvBzO/HWHgYhstij+SmHJNRt18cnZPe7Gotg6oVaDecvgz/dwj+qNHYPxfQe68F1EfuOvAmQrn9o7OVxqcvQ01Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIv2d0fSuZzD/ee6YrE/AKY2WlFs/J2I4ttD+5GIfSrg/AfYIPs
	enzULhgMAqUMjAxzjdp2pvMo4R8TCpPiYkc5S2oBKv/zXVeg4HFRVO1wf3mHj093Ivu4+NlpGs8
	2tZpOE2wWACDHx5/eNxPNCYRIt0mRbYQ=
X-Gm-Gg: AYBFou2PVJq76xxuCjbKdz75pPqvxmyv3jBgmjJ459klZE6ib+86brks70FDu8u7TIB
	evcExJ6/r/Z1bduT163IFVm86lwu1pI3+aaBCDUgOZhW98/0u0thwisHtFdSyIDeHLUWB6sAFwU
	VzMpmi5MkNZEHau/9JHd3ETI69tixtz2aJDu1joTbUp23JLEFTiH5DFxXVzXINN5Z46xrAjz8I8
	+x4fTDZaXrwpcwdL0Y/Q/lB+POSfGWqfATDcQbAtA72dtuaOEToYorOF/KStKND6NoeauILg/e/
	nDCb2X/Ik7ozrmiVZjof99rLFbAENnDWgYhHdfeLBMWOZnvpU0AnDfce0GcX5aOr5oxyRIWO7p9
	+DZPBSXljbs9CnRmDzH22Ac0vfHC4IT18w/QVnA==
X-Received: by 2002:a17:907:3faa:b0:c24:6f60:3f7e with SMTP id
 a640c23a62f3a-c46bdacd03fmr618060466b.2.1792953175995; Sun, 25 Oct 2026
 11:32:55 -0700 (PDT)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024140854.25664-1-a.shimko.dev@gmail.com>
 <20261024140854.25664-3-a.shimko.dev@gmail.com> <20261024-dw-wdt-shimko-v4-resume-imbalance@iav.lv>
In-Reply-To: <20261024-dw-wdt-shimko-v4-resume-imbalance@iav.lv>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Sun, 25 Oct 2026 21:32:44 +0300
X-Gm-Features: AclHuK_uk5ewP18MJ4wJQiIWyDu_xkRz4DfpyBdkJPDFnOGsejWdEyAsYxw39Eo
Message-ID: <CAOPX745u-2S4V_HfwPjkeiC+SLn6Z1GxQOTE3SqMFX75eZRKTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] watchdog: dw_wdt: manage reset line during system suspend/resume
To: Igor Velkov <iav@iav.lv>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, p.zabel@pengutronix.de, 
	Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com, 
	andi.shyti@kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

On Sat, Oct 24, 2026 at 9:46=E2=80=AFPM Igor Velkov <iav@iav.lv> wrote:
>
> On Sat, Oct 24, 2026 at 05:08:51PM +0300, Artem Shimko wrote:
> >       err =3D clk_prepare_enable(dw_wdt->pclk);
> > -     if (err) {
> > -             clk_disable_unprepare(dw_wdt->clk);
> > -             return err;
> > -     }
> > +     if (err)
> > +             goto unprepare_clk;
> > +
> > +     err =3D reset_control_deassert(dw_wdt->rst);
> > +     if (err)
> > +             goto unprepare_pclk;
>
> If clk_prepare_enable() fails in dw_wdt_resume(), we return with the rese=
t
> still asserted. The _deasserted devres then asserts it once more at unbin=
d,
> and on a shared control with deassert_count already at 0 that is a WARN_O=
N
> and -EINVAL; the next suspend hits the same. Deasserting before the clock=
s
> are enabled (or on the error paths) keeps every exit balanced.
> Not tested on hardware: I can't make the clock enable fail.

The official datasheet DW_apb_wdt_databook says:
The reset must be de-asserted synchronously after the rising edge of tclk.

That means we can't switch the sequence of clk and reset in suspend/resume.

At the same time, we can't do a deassert reset in the error paths by this
reason as well (when we have errors in clocks).

Given this, i think the WARN_ON on a clock failure is a minor concern
comparing to violating the hardware synchronization requirement. I'd
prefer to keep v4 as it is and not to send v5.

Best regards,
Artem
