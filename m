Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418A34D3BE
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786269720; cv=pass; b=V6igw+h5S3e+Dnr2yZ+vwJJ0veGbYVz2DktMen8zHOZM8Buo9AEGmuG5pBdb5ZqlIkAqcYl2l7BzlundNqD/L/tPFODgiV8SPqbPF9GkI/xjM8i4pw6Maq2bsZvOllgH3B8TJaSEBGXtcskKRCiIgQj8t61FhlrCHnwa/XdwryQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786269720; c=relaxed/simple;
	bh=/x2G2UyeG5EkyuSGA849izepJeHD1ZsiWWA6fpjB6c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTOnjdl2GAHv1zSTGJxNSOTyw/GcYE9bFXFa5EvYQZ6ZYeKmhRpCY4JbVad5iTmuWZd+rHQdGV9pNs5r0mY2vwpfl0M6uVlaNwhbXTbjgMctsSm3T/AsyIGw2TVKP1/Pexec58FN+q20TpSuZzEdd1MkAwmOrRkdIRGpUnq1zhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+LQTyST; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+LQTyST"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ced3386430so11491255ad.1
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 03:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786269718; cv=none;
        d=google.com; s=arc-20260327;
        b=MKL3wTvpVe3Ce+bq8rDTJL13pfhlaX+99HdhaploJ1RXh11btSlMUL9piAnh65523W
         Njmn+7rdJC09VaLsR/+h7kERMLrU49JxXK3C9QiTik6gGl/Jzd5ghu3cuXRHapkOhFt+
         e2ubJVyoqXooZXGEvnkdJCPd3x8JrGt5hOg0MMOPfCI4F2B2zQin4th5D5ldT5twpop9
         HJjLwXI6wiemzIM+AOCRfibA6L2ZV+PId+YxBBHrHVOxgvedtbLYrjsu2CKKFj23OR5X
         DDP738E5KQ73Qaa6+ryLm207DRBKrSxaV7eMo/kAnrAsDSpY1Pc2IyeWb3Jmz8yMtgiO
         gckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OHSD7QJMUDNSHM5CDmApr0cnz6TMTD5FOelv/tOIfYk=;
        fh=f4nQMzp0N7aT/SUobQOkC4/6C2PGWceYlTjTMYskWks=;
        b=GI6PKHQKeoEfGrzN51RVOJSVQeAnUAi791OQBB2v1V/loi7A6bf7M0+RvB9R7m4XKy
         Nclfygbzb1mV6RC0LGvyLlWz2s8I5xx7p1xNkaOQXp3ste6Wzt7ezl9FUOb/GhQBWPbl
         M1MiihWn2rpvDsyTsoU+9DmXkJfy6TMUAml0fnRf7I9R57PgiYxsabFUULqmz1QJkZ5r
         ZngqSxj7jJ+ARiHA9zy30LRe/8W/2SvFYFsCECapU6SwfOhonV84FlL7MpkU7jbKMDDX
         hMCF6Ys6QomHwnaQiOutbwVyt3QkEOsN/M/wNdZv8NjnRpc9JyIYEMNvrJRd2Z9cDSKy
         5ktQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786269718; x=1786874518; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OHSD7QJMUDNSHM5CDmApr0cnz6TMTD5FOelv/tOIfYk=;
        b=D+LQTySTpGnMZPJWNYGJBEWc7zCqm1B5zc7CnCkrV/4XW3H8/tGoX/GDmUwHO8TH9h
         R65gg2RlTsGCEmjvvmPJPRbRQ4T+qnDTb28Op+rvirBhqKUs0ppp+uzPPGZ097cMdJ4g
         yMCTZm/In8BScvhHLzFl+F268TzFq23N+WFQZgqiDbGQnSUfCyKo2onPK58sqe5uz2/4
         4/3YNy/uTl6t48aAzVgSiKQVlbaNenRprmGjqCC72mzr6DHSIEHhhyjQUF8rWJBxdq//
         lus11BNlC1VsBei6AQdZpiLxliWuosCf9Y5NHJe9VAPGlNJdvvXG5zB1npa8Cq3Fv8tk
         tsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786269718; x=1786874518;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OHSD7QJMUDNSHM5CDmApr0cnz6TMTD5FOelv/tOIfYk=;
        b=aU8PtZg/Rsg8FWOPk7WGdzoJSf3rRiIJ3BJzYAVAQxeTyiWkz7Y7+WjFiu1T81QUqd
         TGVK3RWSGOnLjvIIQJzm+tCJLoh4vlgBPkkf4U+AFT7HdeO9WRt5WmRypRQvmiF3ECSq
         GFVxdK1cZ4BIrGL/tsONLASAayg8ldO5yjfeOn582VgOLINEsj4tUT3lxd8KH5k/tbez
         0mCBxi7Q6n5/4jM1Xjmf6kNjFWNoXDzDGWRTrfi0mDiUFC/Rf0I0freCAqzu0+S1ZOIr
         QBrhlPBT2knCi2NDM+hRr3sFBWObop1UMB/iU1hUFn2T+Sg5VRMp3MocBek+LyAeNAgY
         l8Jw==
X-Forwarded-Encrypted: i=1; AHgh+RoyqiixgiB8NrsUHHhR6ZKn4X0JZUysM6PBa85uiLmfIJrKA4+yMaYszy6B+pASSr1bPXRRy3XK28zCFHUW7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMq89zJTsKlzUBoGQPP6pgi3p05O4i/5lH5kjpzI13AMglIRcQ
	+WPVbKV3Tr/HKDlRF1Vl/iQ9SOWKxmfnNfmo4/j5aNI993IQwmW8Y8mfEa98HLQO3J7ECh40Bo6
	2JJAzOWkXVtyGuvtwpYX78xrhLxES8kM=
X-Gm-Gg: AR+sD11agvgM3/vUJBjFBYlTFWqltRuz4O1+1MwRN3z0WTlpVj8ZXFzRZ1n+X+kDxtr
	6PumpCX/wcF0YmZokBWPwv2MxCxWqKMJ4S1i5rj4RcFhrmNEhnn2k5ZJRsZ4pb1gPpZ0k0L3clT
	hq2oy3jDPvT6CVEO4StourEbAEFPPX/yuasgyFEYd6i6p3SK/ZQYnWDfY68gOe5AbkFAZ+Ht10u
	m/CZvD2gUhhpm53oTn9CwzSU0k+2ijTGbcp2mo/F7W16QBsdimTJ4yiZJPbqVYM675a+eWplPHv
	eFiVzx9gKco+Y0WfpZNa9CLDMo+6xkKLdzW+Rwwci26LWBdGmFMBGkFNrNnEUUByl9lLw000K1x
	z4X0C4k3PQVn72zfRGfPXtmEjnCDvGNFK6PQ74C18mPQaWeqUws7OJxOWkh8BPMIrwpLZHpv0yq
	YZD8m61ps8y8fLsSiC
X-Received: by 2002:a17:903:388d:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d294c223bdmr207346785ad.15.1786269718053; Sun, 09 Aug 2026
 03:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
 <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com> <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net>
In-Reply-To: <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sun, 9 Aug 2026 17:01:46 +0700
X-Gm-Features: AUfX_mw1KVezTWqN2z4u9TeLCw86vjeGY2Ka_ePvHYwoFPbvJwdHv2HuwDWFspk
Message-ID: <CAABR9nHu4pt-Rg8Aq0B6KfKFHX+C1xQmMk6=j8jq1Zn-MQ0p6Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter

Thank you for your review .

> >   irq = platform_get_irq_optional(pdev, 0);
> > +if (irq < 0 && irq != -ENXIO)
> > +        return irq;
>
> This is still wrong. If there is no pretimeout, it does not matter if there is an error.
>

If checking data->pretimeout is required here, I'd propose one of the
following approaches
let me know which one you'd prefer:

Option A (minimal diff, keep existing structure):
---------------
irq = platform_get_irq_optional(pdev, 0);
if (data->pretimeout && irq > 0) {
        ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
                                               "wdt_bark", &wdt->wdd);
        if (ret)
                return ret;

        wdt->wdd.info = &qcom_wdt_pt_info;
        wdt->wdd.pretimeout = 1;
} else {
        if (data->pretimeout && irq < 0 && irq != -ENXIO)
                return irq;

        wdt->wdd.info = &qcom_wdt_info;
}
------------------

Option B (check moved out, before the if/else):

------------------
irq = platform_get_irq_optional(pdev, 0);
if (data->pretimeout && irq < 0 && irq != -ENXIO)
        return irq;

if (data->pretimeout && irq > 0) {
        ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
                                               "wdt_bark", &wdt->wdd);
        if (ret)
                return ret;

        wdt->wdd.info = &qcom_wdt_pt_info;
        wdt->wdd.pretimeout = 1;
} else {
        wdt->wdd.info = &qcom_wdt_info;
}
----------------------

Option C (default-then-override, only look up the IRQ when pretimeout
is supported):

----------------------
wdt->wdd.info = &qcom_wdt_info;

if (data->pretimeout) {
        irq = platform_get_irq_optional(pdev, 0);
        if(irq < 0 && irq != -ENXIO)
                return irq;

        if (irq > 0){
                ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
                                                       "wdt_bark", &wdt->wdd);
                if(ret)
                        return ret;

                wdt->wdd.info= &qcom_wdt_pt_info;
                wdt->wdd.pretimeout = 1;
        }
}
-----------------------

Let me know which one you think fits best, or if you'd prefer something else.

Best regards,
Phuc
