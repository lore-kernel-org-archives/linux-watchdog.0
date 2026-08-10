Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A81F2DA74C
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786329741; cv=pass; b=Y6V81uYcshKE8Q0pcOF98td+ycKF1KYOnEvYtRRoQh6vNk1+JaUsE3Tzk6rjFiQdgAEqnqO/IexKIKFqVj42Md7YhTlrAG/Q/LwrkeR012UBTkH4Z7q6sObPsq8K5CQ1EOJime8D+pIYEgo/lJ5n+n9o1cCwaL8kbMNQSfuOwb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786329741; c=relaxed/simple;
	bh=BzgZl9hnAz3VCgWm+BG62xikp5G3ozdTCOWyDjfeqDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQa7Ssp8iURTMwDO9tpKa7wm0Q3nqOzPb8uIoUrBrW5AamI92PlGsFEO196pm/bcaQrYKcIp9cW7Ntfhs1zE579Z6Obb8f3Qw9epMFECY0gB6lY8MUrP4dxduDyfPXDfzagc5NpQjpOGmpitJexBMhJzOqQCfvOwFEmqtG+clhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmHuEdKu; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmHuEdKu"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1457536b3a.1
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 19:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786329739; cv=none;
        d=google.com; s=arc-20260327;
        b=afOCsKIJxqRnfuu270JU0DHxJy+yO1mx0P61sEj+qD+JJ/Cha2LYAG2AuIpL/N5isD
         BYeD7DyakauCeL9ViYdAAw9I5os0+SOckdFAeX+cWAvnMSBA6b+TQI199JbBn22CTMFC
         tI6FNb9f1DIbRjI5aTEf+qSX2HRB1d2avnYK5O4Last4AWnIRpG5OgJ32MX+H08W35r3
         KsCW9t25nvrqWrzjfp0dWjRkZnl5ThYke2EPLYKpmG1DTx+JKVeGrsnkkrE0KKyNIS/m
         IuNAzNme3L9Y1yyb2iy6/w3Y+BlmoOy860PatQrrekTfl60sc7op/AMVe1ArkxQpn674
         iQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ujyD7jgd2uYoNISfol1DV4SvsMNF2Ff35/OcJJPtWQ4=;
        fh=swl2MwvXb6MFzKkrqmu/u8C55K39qAkLWoJ8J04Rx0Q=;
        b=iVPmTCDT48cyGnc1iP32LMSCH+ErvP+c4n3ZhZSfusvA8xwMDHdcI/FRoUNQh7EkLX
         C+m71aXQvU7jKb9yy1q4qMWfRF9LQsyb0td/nwYDQacQpQO9640PQSM6YPyRmsPZHGxN
         cSxbwwaNa4oT3WdfrM2yg6aQ7ZNAL1mQNxUCnz/h47F2vy0HwXd9Kaq5vFlhoDjQqvI8
         1M5E15e/fAC5ygFSVrDdJbwe3QMdfiI3FAI/yOtG4vhXlPmIoXMJW0T5GXWO9Soph/ot
         3te/ngNtUf8rWk329/iJ0pKeLfQ2ZAkO2taJZOyJfSRIkOypHybDPwRwihoNZzIjajTn
         3B1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786329739; x=1786934539; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujyD7jgd2uYoNISfol1DV4SvsMNF2Ff35/OcJJPtWQ4=;
        b=nmHuEdKuNVQtiPLqYT4axDw7CTNkmeptra2fjMs/MeanTMyMZyQbfYfwD0BrTdxoi3
         zbbzjufvWw1HpFOulkZ/0WLBYMpDrvJzzb1IDeiAAtfqID3QGtqujPcf2vRq790diRnx
         XKVCFEWRcZszpVuEVrqxf5jKNet/I/0gsJbXO6oo0fQB1BQQMkiY3XIpV6QJk/6kZKhx
         xgFRvYJ8OCXp/JAVeJ8vJsfIht3O7mvGo4kbXYnLuJ8cnhfZDnuKrT4ku+wDUeWx52av
         gpoKARbRMQSkRUaYSBpMvdxJcRb0kVRMrXXSgtSOCyHwNmO57U08iWRdu8bOfMuvO4Rv
         tuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786329739; x=1786934539;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ujyD7jgd2uYoNISfol1DV4SvsMNF2Ff35/OcJJPtWQ4=;
        b=lvEQ2J+nOtYFH0F9BXpZ+EPHI1jWPSusx/9Pv6Sw+GHdgc15CE0mXD2uQC/vNh/4Wy
         nJ1HUtUYOx4N7KlFF7dfuv5nkDV467tQWKyuMtfdupoW3D05RIHCMHTw7/Cx99NpcB9I
         Q62b314InRQjhZ7YKLm6h7hE514Qm417fWOxCSjM+JhjWCAzX/S32h/t8vYsqyZSVaIJ
         cL8nnSRd1rw3KsgrPm/DSnj9ZY7ZVj5GmIlqgN6fcCqyzFAN2s/XUnaorVgBwVzss1AE
         uxlnccal0l2Z0TjDu/lYQTnH387bcyjIyekKVKjFFlNR3Fl4GB0mWhCM988/iPttrF9L
         NmxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqd9PFRc19RewWrLW2H7qjZqBfGqZIxwVEC2P/y7vxsMOECIXJ7I4U1EeSK124in9fjzdpxY9knvv0ko33/Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSLTIcuSO40/Tf8SHyMCHwa2SpBko6Cgk/vQam/8d7ZC926+C
	8tapIArw2sL7TvfGZB0gpNxaCNdunelKi3dr/WoIr2pIyoB1lXcD2+ZnjpSisyUvJpLi9QjEV8i
	LYVppsKPZG+/u3tpwTMU8yfrra0Q7sj/wJmYa
X-Gm-Gg: AR+sD112ZVdyXnqa4N3N9eK/36rXPBl1pmrehGxUItOMecoXjpWo4WQSKVWphY/pQfp
	/yD6lcqP3iB5puCYYcuDchtOnAOOZVIpsc10rXjCMV6njMuH3uSNq/10LEKYzd7MJaCM+hbi3o7
	v4EXq9Dv3FMwgMskvF7F6EHCXunKj0lkZMubZ7hTPVUaolz+r0epUmI9+0WikvLTpgG0FoCcEih
	E4HTxA/06xa99Lu3g5/XC908HaWqIO1NAXs9lsWgz3uTvrRn+9Cgf0v7uNDauI+stvqdDhHvg/4
	1nqCsxSvolDjS/mK0WwrZCDm4AUFjDA0pFs84LYa+9a0x7VFUNhZzYZjVI0coSQ4VgG+DMaa8Pt
	yJeqVbq3Yuo2KB5jRfnb5DeZBoRmL5Iiz/gmPk7bpQAl2fe4q0ZbO60wY
X-Received: by 2002:a05:6a00:1d9d:b0:848:469b:3d19 with SMTP id
 d2e1a72fcca58-84f69700138mr18901107b3a.29.1786329739493; Sun, 09 Aug 2026
 19:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
 <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
 <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net> <CAABR9nHu4pt-Rg8Aq0B6KfKFHX+C1xQmMk6=j8jq1Zn-MQ0p6Q@mail.gmail.com>
 <ccd8fd7d-4555-4ac5-ae73-c16e98b8edc8@roeck-us.net>
In-Reply-To: <ccd8fd7d-4555-4ac5-ae73-c16e98b8edc8@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 10 Aug 2026 09:42:08 +0700
X-Gm-Features: AUfX_my6zYcbzcH2Wjjxkf8uek_ej0039cVqQTNpkObFSyVFxGT4TjQ-70scvlg
Message-ID: <CAABR9nEGsisuuQhLwxdcB9i2sEuH=AQb3yaPHPNecya8G_5ieg@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thank you for your feedback.

>
> I wpuld probably implement something like
>
>         if (data->pretimeout) {
>                 irq = platform_get_irq_optional(pdev, 0);
>                 if (irq < 0 && irq != -ENXIO)
>                         return irq;
>                 ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>                                        "wdt_bark", &wdt->wdd);
>                 if (ret)
>                         return ret;
>
>                 wdt->wdd.info = &qcom_wdt_pt_info;
>                 wdt->wdd.pretimeout = 1;
>         } else {
>                 wdt->wdd.info = &qcom_wdt_info;
>         }
>
> (which I think would be a combination of B and C) but ultimately it is
> POV and doesn't really matter.
>

I'll go with your suggested approach.

Best regards,
Phuc
