Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A3937F00A
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358290; cv=pass; b=frRkdBVDNEyP9mR1noaTbajsK5YKrc5niaPSH3eI2kMiO3wokha0wkk7IP0JPNh47sclovFX1MPBzBomFc8OXWKtkPVbRCLwGvl7RtG6rvdfh2gCl0a4ZGvO76+dic0HIm9N19If9+SfVarULzmlTSOfSsKBmsX6I7/7UvbFTMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358290; c=relaxed/simple;
	bh=q7Go9yYok3C95hUOfmQUuxaqx/nyR/Er6G2c8Gtll/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZBEoxvRnVmkY6mTtRzIHAKgQBetN4PoW0UiOloMbe4h44M/B0xEZelZUDc6lV0KIgIbibW50MbXNjbK8Kwa2wook//Rfmfxbl+3OXBwGFTHInwaqP71Ikf/Ag3zf5WCxE0dg79jzULPBr52w5w7MvZ5l7MGXkJaClRiFCVSJ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDw2wdmp; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDw2wdmp"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84f77cc7302so258877b3a.3
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 03:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786358289; cv=none;
        d=google.com; s=arc-20260327;
        b=pyDuLf2cDbDDs4v2baU6ZXk3D1HxEmzXfdx9VVFASiH0JRtysGuBiY750iSsz8/pJH
         GRW0Lsuo0G35SAYBLqimfEtTXLUtRUhpQDv0lNGRF2CL2y444jwyNys8ZnbS48ZFu4Z0
         GMaEehcqXlC/SVtRyI57y557I0IXSHOlOx1kZ6XaZlWOkYaWdmKK6u0igzqE29VXnTjU
         qLb8NEq3Uy74ITopKDZQ+vA5Qf9TJrDBxJnADCk1BdHQJqiZlm8/MilEPT3/qWWTFs9m
         3gvlaYaQmYSi7lZxogfZHq2Ek9MfpwY3h5+Uqk5c5oHbGCQMIfLzI99vdkTAmNthHb8p
         ODeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndyTsAfSWT9fU/X+sfJ4tCXGlqjlZNQz8Rp00QAZlQM=;
        fh=zt2hjtFWVrBSbexOnXx/digRN2O0tNSOK4/ceCsrIlE=;
        b=LSvqmBXlxDdrTfiu6C8Mwa5+PzVVTWNBUPKKHTwFfBEtXhJeLLT7TT9prDgZKOyUww
         /TmBuKzlm8kJ7mLMM2RjZgdCPeKlXOFb9LXZEnZQdyTwFeo8MaqfLj6kFkPMArg1YotO
         q4RBPIfagjQAoxFwzUEvnO02nkvnr24U56DqUk4HE1wAHit+yy4gjHxXzrb6WAXC8oyE
         PRCOtCISo8laDD7CvkklAiPndw1ma0JZsIuYs2RugahGcBt23hl5qP98k8ytkOwTtqwG
         CIUrviVPgJ2A7ilgi6wTEsmU5WJ4v7SvCFRlkxkYgueoByxg8UcIdL22/Pbh/+K4LZvU
         JE1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786358289; x=1786963089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ndyTsAfSWT9fU/X+sfJ4tCXGlqjlZNQz8Rp00QAZlQM=;
        b=BDw2wdmpjKZLQHR4UVuXoBxZ2pRJwCIqNwl85c4Pr/rBov5U2VAMaurRRcAAndSSwY
         9qitH4I+v4XfanvWmB3WFfUIaAzuLvWXNYOe5yzJo0PV5OJxQlu4MJJOVWbpOyOIhQ8b
         YfOydZnI7JboE/A2mP+E3qug7ZaOpL3LLUIvXX16S3zg8W/cbdLw4cIhnf8yHmaLPkqx
         6rVJcAwEzhXJs+4Rk9StNrBgSvZZOtXWCQxwYQ8NOj84M3NInEJ0tA6BBDwiV7FSOVwx
         4Otx5sVjXo3/TLXDLJUMmh0LWaA1XogcQmikFKm9KqYRiQ5KX+BDh/Lyo0MSJLk8VQNC
         Qb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786358289; x=1786963089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndyTsAfSWT9fU/X+sfJ4tCXGlqjlZNQz8Rp00QAZlQM=;
        b=DHvSd7ebRKasnS/zNliH7DplHXm9aBrplScbS5ISWEq0er1uP/wDldRqIRIULUsAWj
         826sJpAVg/3Mh2HviswsBw1+AD+7uXK00q8yrOq/h4e3T565zPMfrk3O6izKc6HhlenI
         Yo0k7hcQ3MKpFjxoG3ckRq7245LqY84iOKoWaQ/Gn2F2Lh7Caq4cccDqrv2H08L18xQp
         PhZ/yD12oigKR0VLx27k61+WEQ5olySakD9znLfJFaBS2htLyFSDTuQ6vDpAtLEiMn0M
         chPoOB07K2QljHg8NXkwYeR0ZWy9iNIJn/4uRP5zwP8l9Ze4Qnrf2tuiUUEI5WIWOGwV
         DvVw==
X-Gm-Message-State: AOJu0Yxe2MiXBJ7xIMF+BYhf2BDgxk9a4yS//ZYkjtB8yapzbVGzZ8BJ
	WK6NPHPBDLrMdL9uOKjREolbKbslB+NVv3Mr+Ih6tBm6EthfJlNz8x/AXH7UgcQo6GN03k/6nzc
	fhSBvsllqI72sZje9m/EKj/GaYuKSSTg=
X-Gm-Gg: AR+sD13cNwQiczU3YN7D6Y44m9kwzHRB9GxVUVhxXqqEixvWf0haYEB8ByHYEd+eFiE
	U/+x/xkJ9o2W1AyEVJ3jNyaU0qGxzj5GIFvLjB+CnOau6uiYQHqWg1QKHOLlb5uz1RmPbeyqhNu
	Qaj4WbTR1bqoZwVHxrowF4sxqgYLWnmpfYrpFL1uVNoINGvmnT7qOZHwqTf7NjKZJoRlE7qG3i3
	Hnjq2iupN1ZM2yiL7/WKXREeuXN9KMn9SWIpQCB57BcvzfEVP27v3qFCVsFwWV2ojehBp3gT4tU
	VB6BMFymPUXF+BquE0S9IKWxlsJ5EUrj+Y60FCbL53Whnts5R7jD8ZlXHfe/YwDXp9liEV6pfU+
	wNvWeiXegVIHZiGk6df5IrrfjPazjYDIqaLKA+urxLgRliWYcptiYRX4e
X-Received: by 2002:a05:6a00:8f0c:b0:848:32f5:4999 with SMTP id
 d2e1a72fcca58-84f696d2552mr19666780b3a.30.1786358288679; Mon, 10 Aug 2026
 03:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810102144.51663-1-phucduc.bui@gmail.com> <20260810102815.3720F1F00A3D@smtp.kernel.org>
In-Reply-To: <20260810102815.3720F1F00A3D@smtp.kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 10 Aug 2026 17:37:56 +0700
X-Gm-Features: AUfX_mzvMK0zlcloRVltWRfYX01mBrnV3QFem1x4obOb00rlOZkyBIDJi5Xucsg
Message-ID: <CAABR9nE=oRUr1XbStf0ztudQ9HM7LEVc_fVcmN7QkQixi4DyYw@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: qcom: Propagate errors from optional IRQ lookup
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [Severity: High]
> Does this code leave wdt->wdd.info uninitialized if data->pretimeout is t=
rue
> but the optional IRQ is missing?
>
> If platform_get_irq_optional() returns -ENXIO, the if (irq > 0) branch is
> skipped. Since this all occurs inside the if (data->pretimeout) branch, t=
he
> outer else block is bypassed.
>
> Could this cause devm_watchdog_register_device() to later fail with -EINV=
AL
> because wdd->info is NULL?
>
> >       } else {
> > -             if (irq =3D=3D -EPROBE_DEFER)
> > -                     return -EPROBE_DEFER;
> > -
> >               wdt->wdd.info =3D &qcom_wdt_info;
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810102144.51=
663-1-phucduc.bui@gmail.com?part=3D1


Oh, it looks like this approach is correct.

Option C (default-then-override, only look up the IRQ when pretimeout
is supported):

----------------------
wdt->wdd.info =3D &qcom_wdt_info;

if (data->pretimeout) {
        irq =3D platform_get_irq_optional(pdev, 0);
        if(irq < 0 && irq !=3D -ENXIO)
                return irq;

        if (irq > 0){
                ret =3D devm_request_irq(dev, irq, qcom_wdt_isr, 0,
                                                       "wdt_bark", &wdt->wd=
d);
                if(ret)
                        return ret;

                wdt->wdd.info=3D &qcom_wdt_pt_info;
                wdt->wdd.pretimeout =3D 1;
        }
}
-----------------------
