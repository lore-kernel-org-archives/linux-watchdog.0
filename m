Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673222;
	b=xJX4uxuVd+Pu57u+NE/DgkA9kTF1cgT71bzrXbao5/v2ur5j1oIxfqcNGqGJxYus7VUe
	 29AGA6oR6shADW12KQeOgT5ZbrPqPo3+eYYANXvqu2d+CfXOYse89e6hQTwFEG3sEgsiE
	 KLMCD929+zWIqhaKF0CIk3Ws/VxGTWThJXKzqSzWGXJtDD0BDsdWaMioHg6ORYYxD9rSw
	 7PPN2sST7IdPjpv4vd5ARupsTuTkAvOIYChg/EGZp34VGUPONK7NhndT+A3apnq2IInqq
	 KkNQZwyCqXtkEIZPYDopukFnbAHHnVM/mSxUwO9gkzDAYzJ2GZhTfjp0MHhmPFeDFgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673222;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4p3UHmuD6i3FHMzkcfROZluK3zJL3qkZsQStVmiHRmg=;
	b=boq/XAgf1JhhdQMp86EmU4HPrWvowUSZ1Be1kNdspnQLF/Ek+3EB3KSJSBhe4Y//r0/k
	 ZaBn8AqxkrlHLORAoOKIl3ATdYE3llJ29wJKlQLPqs6E/F8Q6r1qKeKSMyF8MFGwKZ/wS
	 O+J9+EjooXJaqfrtW2MX3OZ8vs9APQ6s2AK5JhQUHHATJbOUYitOy63ZygURMiIO6+mSV
	 YmSO4HwFWKkoZ1n2JMT/pCc1rXtCpzXBjIOn6uD0cAD5iCzoj2xrJoFGYLx3uHwb9ajUE
	 kPZElrBF6+Aq3yilRW1h3dWUNE67y21Vf3IdJqEqIi1pYS8jYEq1ozQpFkte3wbEf7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="h+/YFhTb";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kRi2cVyG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E75606A321
	for <linux-watchdog@vger.kernel.org>; Thu, 26 Nov 2026 06:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E75606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h+/YFhTb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kRi2cVyG
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36LwL394050
	for <linux-watchdog@vger.kernel.org>; Thu, 26 Nov 2026 06:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4p3UHmuD6i3FHMzkcfROZluK3zJL3qkZsQStVmiHRmg=; b=h+/YFhTbeX1fcdl2
	7toz/08qhrPWD6DYf4DF0WKA7b9UB/Be28Vwp/2eGPaDHIbrIxd+8LlvO60kVT6t
	j+THMnhwAnjoepp2yhd+MPCMz+rsGaF2lxxspA2+NLnNsy3qtaQLkpPhRS7xGpGC
	nDa1IytaNxNt72y9/MUWKiXSiYsYrcDopzp4C3rmEYTeNjRp0iL2l/KIZdz/I/W5
	9iRdRfLjcWiFsmJB6DoLomTlsM5Jn33iRr/uZnYYMWcwDJrmMN1oanFW5C9MVL9P
	lW/Dzc1I9+EXTyc2GEktZJBubh3Raeho4O1fi0caZ8QTw8bjd5n78+9H4pi+5rGk
	mhdeOQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y1muw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Thu, 26 Nov 2026 06:07:00 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-57e469f8312so1945670b6e.1
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Nov 2026 22:07:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795673220; cv=none;
        d=google.com; s=arc-20260327;
        b=pI7tKahZcC4keek0ZQBqs6qWG5nfJOxefCacTUB2i04reZxLhhOGiG/XXNaCRqf20G
         EfxOyD5PiROO14BI8KkJ0V1GDUimVZxvlKJ31L0HwR0NXiRsUXPOHHm3HMjh+USnjWQX
         aZe+KZKbRjTPPibaBgXQJD20M00FZrie+Lw10eijM9jPsjysbMHckFYo1wsc/w3OLYvu
         OZGK0XgSRn9iz1daIEv6kLH6rbAvWVQL5u7nGUpgBCta3Z31+bsRYkxIXzAl+6EcOLNt
         V7RQK1gLE41w04aWwS+XRXTeeC7RhKc2AGf1/yMlFG378D7amz6/JEOOoSw5rWmA2Wu3
         XAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4p3UHmuD6i3FHMzkcfROZluK3zJL3qkZsQStVmiHRmg=;
        fh=/T8QaT5+yaLVQwvh/HrYN2CFqeqs6Cf1qk9N2vbHbiE=;
        b=jE5X0pljz3IXlYs3kSvvyOf6VzndJEFKEH2Y2d7HQj7TEQOYJH4FN1gC8WijBrhK7U
         TEpun2lBcAMBS7RaNYvGdsjo4UG4h8zsMQqybTjglyuixJrSy9v52TGZnZvMAFxTiAWz
         kSi1welfSa7PDta38d1kBe+3RCQz8HthyvFEdT8mFafgsfRYetKj6yBCx4Sqy7I9IktP
         KMbrWJ9ovrl5IB1Ur7ERfkuTl/4v/h+so9Nag2HvC9IYi/ePHynMbum4XsY4oWOXPWlT
         MQ9T5vlX3UnvY01I2+6eL7shNyHbvy3geSlvGZBJeWoCqOcE7WebfNtYwd07j/sMjL9H
         +/fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795673220; x=1796278020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4p3UHmuD6i3FHMzkcfROZluK3zJL3qkZsQStVmiHRmg=;
        b=kRi2cVyGCHjtDZXNP45Tl5oD5Oiw33AFLFc60VGQTkJu14zv2YX9dLQoCNI18Q1R7L
         EReLEkGWfq1fW7aKoDEoIYXHDz13XLsyaCDDzBvpKck2YZAGiE5cuP9UQLAupNTUv8IB
         uP31mETDHIjo1eEHCqivjupTizhWaaloYRmBS9T5sjXjeFDYLb7pqsD8UyjMPzJ0n0Lb
         iPpmFRJt+9kvVkyKsFPHlqHhLgijCXigmsNS+9yNDuybwu0zhf5JzJCEgzuvcZ8LDDGU
         7guramW8vsaxgfhKR1YCqPNJvlWgRDRiDeP6fKTr7PyTcoRxPaQAq06aHTFEh8qWKmej
         LL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795673220; x=1796278020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4p3UHmuD6i3FHMzkcfROZluK3zJL3qkZsQStVmiHRmg=;
        b=UAguB0g0MA/VIVxlidTw1TS+HjXz2kA/OlcYzIdWZnRE9ZEvGQ5uVCbenL2uwgWDly
         62tv2BrDd9Y6DMMGj5ziHqc8D4QeVO0Z/iS8mTYaSqwc0I4x5lJZxeWQbwq9HbIIYtxR
         Yv1vEJOx88CnEqeZP5ThBdxuivGU9S2Rc6vUKMcYy+rbG14Pwpfyr5Vdpp1QXrfNdvOn
         eB+Z021LwpCc20z4LvTDj0fQz9u/XBkTTv9/XkDzfncgq1TP0XM8krttBa9NAIqmBdWv
         S6HMC+nEkLbJ7S3Vf1v7krKBsyhljweqodpGAQuNcDXmFoLDb6G4NUNM1eEGyc9EZXqP
         ONYQ==
X-Forwarded-Encrypted: i=1; AL+hErEjjiZxwN8sNLconypNwu6/7fjihwZxMbp/sCrEq2I7MEONkcA39nE4sEBd12wS6Ha/g0kNU1anMiQpQcWARg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9rbpgBF94PkQE/qFJkEGtU+Nri665HAzZuFM22Xijrgf7fzh2y
	HXPd/ln/9R+yJfwUF7ID50L9A3ECqXqyUcVVqx9cvlwHoizlqddqWv7Uy6QiVv+kgz0PldFlA6T
	kUjTqWEXv7orbiNBopxE5BsqjFlaJXWnkbpS7hYj71Dh8RzeN3HyEs6F2NjPP4WrT7XDKKYjIho
	2uqEY7RwZ6Udisx7+c9TqIX3iiZA2w01IIN8UiLYhqQXQx
X-Gm-Gg: AZFdTZeeQ5j5xv4KDMGPyIBRMVr1t2G2KspcqtDxNsr+ighFpqCkwytQU6vkaw10+19
	wflylDkLX8t3JSeJd2Jfzblb1aKQyudH87dN+8zKJZ3WMayZPC56qIxwGkIXMwuqTMkeOnr6MZm
	FDfz4ysS/X/uus5h2qkU9wnFMZLNHO50FXeMuUJnLo0eRdTSVgN8CGchkXnQ==
X-Received: by 2002:a05:6808:199d:b0:4fc:248a:de3b with SMTP id 5614622812f47-57a0a212627mr23641735b6e.23.1795673219782;
        Wed, 25 Nov 2026 22:06:59 -0800 (PST)
X-Received: by 2002:a05:6808:199d:b0:4fc:248a:de3b with SMTP id
 5614622812f47-57a0a212627mr23641719b6e.23.1795673219369; Wed, 25 Nov 2026
 22:06:59 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124131542.613271-1-prajwal.n@oss.qualcomm.com>
 <20261124131542.613271-3-prajwal.n@oss.qualcomm.com> <sashiko-outbox-231227@kernel.org>
 <fa2fe9f8-04be-4692-97be-04e70894ab20@roeck-us.net>
In-Reply-To: <fa2fe9f8-04be-4692-97be-04e70894ab20@roeck-us.net>
From: Prajwal N <prajwal.n@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:36:48 +0530
X-Gm-Features: Aa3M54p49nRwbicntIbUh81KPnbFysaufURBklBNK_PoXr_KQKIKDtEWQlpzqeI
Message-ID: <CACksjdgezmM6DMZJB=5=VSxE3Te4KZROobpdveJPsAZdz-ULkQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] drivers/watchdog: Add RISC-V SBI watchdog driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: sashiko-reviews@lists.linux.dev, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfXzXeL8PtYqxRl
 odIHBg8pARp2oISU13KSzHX7Dvzc8REt+TIeJaA/lZ4hPDOm+Wx65QCjEIMo/8VP5z+Fo4q1Feg
 k35LU8/qDW/EDGeRAUHOWQzpPjpW/jJ6IBcOXT+H0PcyRz48pGVlqyWE+2UAIm2MsIjj2UbIR4B
 HPREFJl1NM4yVDxgBZ/qbQqXiz0+NAVcZqUmpaDtj7MjQGb1yW7z+byiMY7e7vTZO5StVMkAkwW
 gSdJezIi/u0LswV2Pge92IFfQRh3HP4O/0gHCFwonmgBm6aNFCP7waNR0B5S0HZsukFgC/0SOH5
 sT2coOb3zSKtbIym90Ey/5bnsDnJPTE2ABwGz0cVUHc3DkhSzqD29D+8+RttUbIJQ9Wha+XBwY2
 4TsTNJez41/9jTzziR6GRqBKeCOGqGBx92YIaQDluttWxAGKpZ2HJGB8JncbucaCrEU45IFPVK0
 LMTs7AHVgxEko28+QjA==
X-Proofpoint-GUID: IAc-pM0b1eA9bpWJf4A0vt_KB9y6iPAW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX1GOQNlLNuGds
 p1I8R68nr6lXvd2iEpQcB8Kb8PMQaAlqp4KwL5a3h4xDhQ6wOKsQAwz6wETgfnulrFWZUUydrK+
 buuV84jMwVIKa8lkRpmDnoJbCqkrxe8=
X-Proofpoint-ORIG-GUID: IAc-pM0b1eA9bpWJf4A0vt_KB9y6iPAW
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b07cc84 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=tj0QgOCiauEWum_1KWcA:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260023

I will add a brief description in the comments wherever necessary and
will send the patches soon.

Regards,
Prajwal N

On Tue, Nov 24, 2026 at 9:42=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 11/24/26 05:37, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential
> > issues to consider:
> > - [Medium] watchdog: riscv_sbi_wdt: unclamped timeout bounds in
> >    sbiwdt_init_attributes()
> > - [Medium] watchdog: riscv_sbi_wdt: stale firmware pretimeout in
> >    sbiwdt_init_attributes()
> > - [Medium] watchdog: riscv_sbi_wdt: missing running state check in
> >    sbiwdt_probe()
> > - [Medium] watchdog: riscv_sbi_wdt: probe fails in sbiwdt_probe()
> >    without S-mode IMSIC
> > --
> >
> > commit 7154e44eab330baa1ded9a131b702c04ae8a2530
> > Author: Prajwal N <prajwal.n@oss.qualcomm.com>
> >
> > drivers/watchdog: Add RISC-V SBI watchdog driver
> >
> > This commit adds a Linux watchdog driver for the RISC-V SBI watchdog
> > extension, including MSI-based pretimeout notification support.
> >
> >> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv=
_sbi_wdt.c
> >> new file mode 100644
> >> index 0000000000000..8e3db98547882
> >> --- /dev/null
> >> +++ b/drivers/watchdog/riscv_sbi_wdt.c
> > [ ... ]
> >> +/* Initialize the watchdog attributes */
> >> +static int sbiwdt_init_attributes(struct sbiwdt *wdt)
> >> +{
> >> +    int ret;
> >> +    u32 attr_val;
> >> +    u32 timeout_usec;
> >> +
> >> +    /* Read watchdog capability from firmware */
> >> +    ret =3D sbiwdt_read_attribute(SBI_WATCHDOG_CAPABILITY, &attr_val)=
;
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    wdt->attrs.wdt_capability =3D attr_val;
> >
> > [Severity: Medium]
> > As reported by Guenter Roeck on RFC v3 [1], should sbiwdt_init_attribut=
es()
> > check SBI_WATCHDOG_STATE and either stop an active watchdog or set
> > WDOG_HW_RUNNING on wdt->wdd.status?
> >
> > wdt_state is declared in struct sbiwdt_attributes, but SBI_WATCHDOG_STA=
TE is
> > never read.  If the bootloader, firmware, or a pre-kexec kernel leaves =
the
> > watchdog running, writing SBI_WATCHDOG_PERIOD below can fail in firmwar=
e, or
> > watchdog_register_device() will not start the kernel keepalive worker b=
efore
> > userspace opens /dev/watchdog.
> >
>
> If you don't think that is necessary, please add a comment into the code
> explaining the reason.
>
> >> +
> >> +    /*
> >> +     * Read watchdog min period supported in firmware
> >> +     * The firmware ensures the MIN_PERIOD is in valid range
> >> +     */
> >> +    ret =3D sbiwdt_read_attribute(SBI_WATCHDOG_MIN_PERIOD, &attr_val)=
;
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    if (!attr_val)
> >> +            attr_val =3D 1;
> >> +
> >> +    wdt->attrs.wdt_min_period =3D attr_val;
> >> +    wdt->wdd.min_timeout =3D usec_to_sec_ceil(wdt->attrs.wdt_min_peri=
od);
> >> +
> >> +    /* Initialize the watchdog timeout to default value */
> >> +    timeout_usec =3D sec_to_usec(SBI_WATCHDOG_DEFAULT_TIMEOUT);
> >> +    ret =3D sbiwdt_write_attribute(SBI_WATCHDOG_PERIOD, timeout_usec)=
;
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    wdt->attrs.wdt_period =3D timeout_usec;
> >> +    wdt->wdd.timeout =3D SBI_WATCHDOG_DEFAULT_TIMEOUT;
> >> +    wdt->wdd.max_timeout =3D U32_MAX / USEC_PER_SEC;
> >
> > [Severity: Medium]
> > As reported by Guenter Roeck on RFC v3 [2], what happens if firmware re=
ports
> > SBI_WATCHDOG_MIN_PERIOD greater than 60 seconds, or near U32_MAX?
> >
> > Writing an unclamped 60-second SBI_WATCHDOG_DEFAULT_TIMEOUT to
> > SBI_WATCHDOG_PERIOD will be rejected by firmware when wdt_min_period ex=
ceeds
> > 60,000,000 us, failing probe.  Also, if wdt_min_period is between
> > 4,294,000,001 and U32_MAX, usec_to_sec_ceil() rounds min_timeout up to =
4295
> > seconds while max_timeout is 4294 seconds, causing
> > watchdog_check_min_max_timeout() to reset both bounds to 0 and allowing
> > userspace timeouts that overflow u32 in sec_to_usec().
> >
>
> If you don't think it is necessary to clamp wdt_min_period, please at lea=
st
> add a comment explaining the reason. Note though that "it won't happen" i=
s
> not an argument or reason.
>
> Thanks,
> Guenter
>
