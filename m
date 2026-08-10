Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6F3B6C13
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357729; cv=pass; b=PDxPKFX932QfMofOdsFvgFC+z01ShF6Wo6eKU4lH6Qrvh5S9H6gy0ayfD7PBSBrOeJ+R1GMHRXY+ag7A4+puIhdNRWywM1yQUmKpqM0hfawVPQgo6UfvGBvitil6uCxNSmZsfmFpA1b2DJPw+1+WigRZ2HOBWqRa8ej3oLt0FRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357729; c=relaxed/simple;
	bh=NJ+gOJyER9vuv1qanBVyuaipNB75faU7GwlhL2xTp3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohFPmgGYOldeOP1Sk3/lGLZ0YoKY+rfAmk652+1JXOtngx/jyfmXYMULGk7omfL7eiuzoXzH+wzUXLcQHRtGpys7MxOz9C1VKTMwUZKYLxJzpDQNELOq4LJBSc6SodlPyApdMBz6vIc0WmuyMXpsy5dWzHNwCiEif/m4X0Z493w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpUyFETU; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpUyFETU"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbb85186d43so819519a12.3
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 03:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786357727; cv=none;
        d=google.com; s=arc-20260327;
        b=m1tia/TW7BIV18YkjDlzAN9fRu1mWBvD87FCbKx8eXMsAPDYw3QfrXhoLAvLZX+fAQ
         iAdjtmEWWhfFATKQz5vvAOf3ZCEbtojc6PFVpuaXtlz/+FuLfF3ZX2HkmRNYrU2KtRkW
         dyNdziQHpmdYumF7eTcN0Z3gFGPxH60Jqewgcrolu3fdIchD4noJa35HsCFqne+Ek7jd
         l8l5TTz5GLRmdtlKfhREMSqsUfBwmiOpIWDVa/rR2P/vsN3XBQy8oDouULDVFlB8Dq7z
         en7oJHF4ZEubjtIjAmcBoZdjbpHQU0X/PGphOM6QWuBspdTnBFcw8Rjgrjyx+hK5raKN
         mvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7YTR97iN4huYLj0yN+iLMysq/MXHzEcd/JYnaemRb5U=;
        fh=3cLVpiIyyDAxOvp6RWVwXjahd4JY6mO4FhVqiRdHgyI=;
        b=npIUSAE7P6oi0YUiBg2axY4lpCFLCJnU6/a96lEoDh2Lx3kQ2VtIPJ5oaom1JU4bbe
         E0t0SJd36XiarDcD5t5Q6N3SGP6TRQXH33r64Lfy1jyWjrbeXin2fvYsxQC4ze7CxJTN
         gW07UhlP1Ra6WnS7+1YGEKUp5GGpzSbcbrq9x3vdlB88dRDJ5W9mrHf/6P2ieXs9Kxk8
         yUtnrdZakJvlHD1gYzx9d2tRKr6r2/02YbgdwNmYlkaxe6WjNF6jSiZVjHV3RPVFoj+d
         SgnqPTCp4gnRPldDIV7qcgES6V1nRS3O57MqZOi+50W0c5X818bToqJNBJyjhtm1OqL6
         U/qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786357727; x=1786962527; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YTR97iN4huYLj0yN+iLMysq/MXHzEcd/JYnaemRb5U=;
        b=UpUyFETU+JYmykOSEwcQ8LjQ6c6ioW8mWGQ8/c4Ykb78uuQTrmlYK/fCvHB2klIctI
         gwjfZPAMf62dt9iNJOizN7skdAUw/aAaEoBWRQuc7Pbg1oYd29+xK0lSGEMBvP+uI7aZ
         K3TwltXVralyGm6MVdeBbXh0EUunZPcssds4SOtHggPmnS2L6MqBcTkBWsIabrim1wwp
         oJDiEV2xw2fPVxloU1i7J76Qepf4QQtJizYXMpqiAEB4GDHo1EhWbKIL35oA+ydQXrIf
         +oSDNTXqr9Qu5Tez6fyRSIitWXpOJYAwN99RFZDFjdGvZC4Pp1cRmNjAWKxeLSVPCBDk
         ldIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786357727; x=1786962527;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7YTR97iN4huYLj0yN+iLMysq/MXHzEcd/JYnaemRb5U=;
        b=QoYj1eRDNvZGOMGJq+9ONAEjuLp8DElayqmngCN4f5VJnhB9YFkmQNjirx4/ivXEPB
         9elXerI7P23iZ0D0ljznR027xUhIKqt3AmyhFrQMrVNt/RhF5V5/RBDDXnFbyTcnr189
         8Z/qT9RKwU8vdjz2HNDUYzV7kAXcDJjXXownTqmqu/J8H2gZeKVNVZ1UaMoBoZhhC0YI
         Wtf+rf0BX1srvOoCsyiEhG/6GM+HUyIda1G/sXkjWxSRRCZzsX1paRkPqsbvQjpDTxr6
         t4HDyuf2fUcoZ9GEWRLR1Q1kWxofvor0gqFRIT4s8uOsRzjikVsZsVUCuqOaP3e+lm5j
         mlpA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/A9m/o7OHo4ZKyxMC57YVTfTkYcyZmEyKSKBrDsxl7+pOosuA8u2djW8s3/FqvAvQu3I817kmwMOKOV9QaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaCqk3yqrml7/fIxFukFrRKRLDlGAgeeZdFHp1Oh0Ou8s+XU6p
	ZOSllumLA2pARzQRikMzItjDfjYbGnJP05SdtpML13zTfHRHw6apLSMypfzQ/LiAgf6DwOQDDaJ
	cPmcKnxeXAxgceASit8LuIbcg5gVF1pnLJd/5
X-Gm-Gg: AR+sD12L9c+RSk/lJA6GaZnzsHxedQAeQofRMf1/Tq0gIb+0EYEnr5my+buLjpx73F9
	rCg6MWnpewTpSLN/faDkEMK86NTtbcGynGHvE4PR9tBFXMnGWzaIrLSj2tHcyaut5I139T1HDOc
	kWiJIk85nx3IZWf6ibxr0du0vZajDEM1C62y3Dbg6SRpGW0LhRj01ck9IW/sNkoP84pPHlB2SH+
	tBVp3V3sdGyteG6kdLf0SOP82lXDiCkCyge9PDXJB0/xFOZdZY+aesnEW+HEcprQZSRcss1ckT9
	WBd567l4V1XfP88dosYgMsHKOyz6qOVUCsGCOvBiphov4N84oimMT7q3Z5wy7RyTMpNVe4SgEGF
	MMaCrB10Uh/sk/+4O7JM/UbBBtSV5Dzu/Xcjn6yRMmuM4ypXAD5yVUAmG1g==
X-Received: by 2002:a05:6a21:6816:b0:3bf:6237:4d49 with SMTP id
 adf61e73a8af0-3cbce8d8e50mr21153545637.23.1786357726807; Mon, 10 Aug 2026
 03:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810102144.51663-1-phucduc.bui@gmail.com>
In-Reply-To: <20260810102144.51663-1-phucduc.bui@gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 10 Aug 2026 17:28:35 +0700
X-Gm-Features: AUfX_mw8vSRjmdPvyZVAESG2gMLDkL2HQihsHgDGyihh_Qx9McD9iFIrjFgXO3I
Message-ID: <CAABR9nF=Udo0Y1gAZKfxodd=B5LJVQ1F9p8DzcDnZ+OSM30uGw@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: qcom: Propagate errors from optional IRQ lookup
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-watchdog@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>         /* check if there is pretimeout support */
>         irq = platform_get_irq_optional(pdev, 0);
> -       if (data->pretimeout && irq > 0) {
> -               ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
> -                                      "wdt_bark", &wdt->wdd);
> -               if (ret)
> -                       return ret;
> +       if (data->pretimeout) {
> +               irq = platform_get_irq_optional(pdev, 0);

Sorry, I missed removing the old irq = platform_get_irq_optional(pdev,
0); line. I will send v3 shortly.
