Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793606314;
	b=i9XOpPLthRt7kTnxjQEJltQDrtGlIIFGiITjIZk7xefE0asjDFlzLPe364mQcvNiQbWF
	 R4ZaZBpsIIber1TVg25vtSe2fdGqhsH7Qt3fi7iIr+a0W3fVZZjzBTkrLFvBsELyKOSsK
	 qqpZ5FaxZByMk15UcccqtLlww/ZHcS3NeD0hQiDUnzdq+8y5A+jQU6KNUscypLKIuBZAA
	 MUUw1BQOVuc6kOl9tVZqnTqqQ1xf4Ig0jA1XvOUOc2L93OAHC59OE47pAFOlB7OogsYzx
	 HKWzLfhEcpFxHHG7CXP4dp0Nec0IykETSoZ4HNDeLjKpXqXr0mcmxjVSze7P7gEL+RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606314;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mZtzL6L1EoDOHZONsEcrNhJF6H1SuAxplHE71RmsGpg=;
	b=bUEICyxBpPnJg6zkO+9lE2025+wsNyi7FynAFECtuBwQ7VpqXk27Ce8uqgsdWbZ14frr
	 xhhkA/R/enTglbGIRzFRAx0G8KSm5svYPbU5NyYsBJrnKdZgjpYSyPrBKVSdCXr7oWXBX
	 abMlkV9t/CAqUK7v0ngl1jZN1wG9OQO8yN7U8Xuo/eZfJwbaPTzv+VefOxV++GNIWNV/L
	 Gwv+MC3z/ZQuGyW/xzo5zqxsfhqE2sxZLyFoidZTAs2U4++aB+iSVQG7QdrZ6NsqGdmCA
	 2AvUWUT7w0RP2MKaWHnqX/pJcv47+52mVPlPQnTSbOY90I2dec2ZytXiYshfLC2RLqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E4QBBpmt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O3xbwUyd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAF606A324
	for <linux-watchdog@vger.kernel.org>; Mon,  2 Nov 2026 07:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39BAF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E4QBBpmt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O3xbwUyd
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23v8jl3768682
	for <linux-watchdog@vger.kernel.org>; Mon, 2 Nov 2026 07:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mZtzL6L1EoDOHZONsEcrNhJF6H1SuAxplHE71RmsGpg=; b=E4QBBpmt2In7Qmu9
	DBr0LE+pGJpfLapynb5jfL99S/lCOktxbQfVyTRn4CSDz1DSmsJ2oBL/NNhP0JHK
	5+veM3/zJq/NFWcFcm5zdZcx7tjnWGiag4D5wcQotc47jlPzAFsMlmZkgovYrpQX
	QeSL1JJXGgaCyIsEEz64gOzS5eDvOeXpRf1k4LYkc3rncdkk41GT0wHASrWqkVid
	RB0TRgXetdcGHgQjW/GEBILPs1TClhdCLieLBtbZuoUWjbjx65YwGJOjQf1LN8km
	RKA28BL/PJS856gBNrF1bk1bDRd1dwr/nJECrhiPFYQyGCE/R8/jTDFCeuGGVBlu
	lI/O3w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79rwwjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 02 Nov 2026 07:58:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd60a365440so1774625a12.2
        for <linux-watchdog@vger.kernel.org>; Sun, 01 Nov 2026 23:58:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793606312; cv=none;
        d=google.com; s=arc-20260327;
        b=OuWFtnVdtm+uHjDzLut+XWVs7RDFEZTEw9tGqayVDhnZaR7ZUKU1V4TuwbzqMUfpY+
         WcvjHDZT7XkUQTGb0RFFpC1toxUCNUf+x04ey3aK4Re8UVfFZf08Tz2yCvrEdtV8b+kD
         eHx3lXGNH3lWJBzVlA9Lpfyir4HFD+9tPWldUj3g3bq/SDfH9yYVsGTRdFVNqdlNnUfv
         /3l+t1Jah8UzCoixcgjft7/2Vl/73R4QDSwj9q5vQpCAR52jEcsyrCXRoE2zH544AbjJ
         419pHs+hUnM3zL+ogfCF7gEfY9LIXngzVjl1OeIjA/TvN9g/+IP9upckGxRKFVUITmg/
         1waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZtzL6L1EoDOHZONsEcrNhJF6H1SuAxplHE71RmsGpg=;
        fh=KmauTIdyvTTiYN20/h+eoS0iDIEW5TfPUF8jVKxkmLA=;
        b=Kr+ZRf/EkdXT5vJPb0JGmayRRaN3uEYgzoxU5UCo9YH6m4RN7BiCZ1Agq54U5HyJvZ
         rJD5Q1L8wVXNqx3mO1FbGM2dI4czZ6q6lLdB9QrAkwCmn733LSHLljn0ysgzKr5kae1m
         dYM3RldEVEhdpbjNkn6UIbTm4MICxeZ19/bYVGnpoCDrcowNpZzGnmjF3cJUQlS1+ykh
         kzhnNpg2vBns0avBeJ3wtOOr2bCu2dlOWmZ2daTkg4prM+I1/EcwyVB28RJB7Ye8quYt
         pEnUYS1PSevvW3ypa2LW4+9wkW366iedXQNYyNWJj6wxRN1WjBoyMWAz3pAixaulkXIS
         na2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793606312; x=1794211112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mZtzL6L1EoDOHZONsEcrNhJF6H1SuAxplHE71RmsGpg=;
        b=O3xbwUyd68h/IPTMsZUk8EvGZ1Trc074BdZ9LT7mgpLx+v12lcfK38y5LuZ3Fnh+1d
         E0Hnl5+jd/k+z5JgBNmklf0RjlzkyGChqFzbQYhCq05GHnZE7e5QEnHNM4p1BpIGKjUt
         atQmQTeXIDKeVg5qwYZgXILdU3+GJ7NzwELU2fh9GYzjj3d3pgXne2DoF2wMF86KqlD5
         ZulzSkgXkoEEaSwC2NnTR7aja3mQZwuCaR1Qhog9UUELVDbCGUuncsP38Mi850Kib0fI
         kt8t5QXYMPCyJ3IXHNBU50jCPz4V/lRPrqyd29/P2R6joBT4rByiUf2H6V4GlpPEuR+G
         mJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606312; x=1794211112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mZtzL6L1EoDOHZONsEcrNhJF6H1SuAxplHE71RmsGpg=;
        b=KJkkpgctdknkhBjdXNGxqyLIvaQibZHVHsba8okpTDxZuaDxlF6stub8EvI/yn7lbh
         c8SQD6YndPDHDVtNFm0AGrY0Dyv0MMudjchzbytb4lagz/KAF/t8vfHYPkqBtubTML01
         1QIGHnPwvT59s67R97nX0fASJU89tJa0pOlHXA2zpP9UKj44pledky5wDHZrEuIo02k3
         7xM+Z9WIn3rQbHts8vQt4RCEeK0TKOpWSy0DEs5zvA+MXW4P2P7HEQlken1BTVcP32P4
         AhPvv/SsaL6ZaMmeS1AMIXsP6kQjSMVVC0wBSqdnND8vWR0TtTaUtH2jbJoMdqOhr59o
         Vkfw==
X-Forwarded-Encrypted: i=1; AKwUvBziLjGRHgoUiZz6Uqw8Ie8GQRulcfCMMFHC/9QCrzJas9hhQxvn2yTwz7zzi5xuoJMtVSqJ5n5FnpE9p8COEA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLWgaTcPp7/J4itTlRbRT5uK3OsREBT6U2LYTQiSj6RC6J9F2G/
	6quRchriKREQUUnXf2zeEAorBMM7Ex70UKyPTelVDRL5xMJhqTRU79FcCeo/esRNpMnl9eAK23p
	gfEjN0pTlppbker/Mao0mpU8LEmwZ35GxcnKwsQw14NTynLoehEW2z97GXhlrNs7w4diuZOON8A
	/N5eIODuyn/66MTTGKDB49NB4g5fp7Il+rWHuNkJrJzdp6maCnW1bi
X-Gm-Gg: AYBFou1Xkhw7ic5qQnyiOkpFtGqUvRK0oy5HdeY3NiDL4taa/HslAusWYa07EAgLB+N
	c5AOAKLUhdgNlK+rCOOyvehaG6va3ikO/rieYCmJtKopKsak5upiss0NX5lkoNHbmCtkzGcsQhM
	dmamTza0NdluFlz94Y8ZpSbOcoRAesTuDzZI5ajFlM1LP0r4Cw8Y+/6FOHqxU=
X-Received: by 2002:a05:6a20:a107:b0:3e2:117a:6307 with SMTP id adf61e73a8af0-3e928d4476cmr8481703637.22.1793606311466;
        Sun, 01 Nov 2026 23:58:31 -0800 (PST)
X-Received: by 2002:a05:6a20:a107:b0:3e2:117a:6307 with SMTP id
 adf61e73a8af0-3e928d4476cmr8481692637.22.1793606310865; Sun, 01 Nov 2026
 23:58:30 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
 <20261002163758.2919372-3-prajwal.n@oss.qualcomm.com> <20261003013318.E74021F0089A@smtp.kernel.org>
 <67c297cd-eda3-4a01-a2e8-fce6c8993728@roeck-us.net>
In-Reply-To: <67c297cd-eda3-4a01-a2e8-fce6c8993728@roeck-us.net>
From: Prajwal N <prajwal.n@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:28:18 +0530
X-Gm-Features: AclHuK-dbBcZ1fvqVNA-El92LPsB_Qon-7NFUwOnbnYEauxMBxxJg7my1dj6rkE
Message-ID: <CACksjdiGfgyNXiSZjNyZ9M+j92HJ1xLKDYgwz2Ymh+6g+ht9FQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] drivers/watchdog: Add RISC-V SBI watchdog driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: sashiko-reviews@lists.linux.dev, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: AXWQrYF4l_tlW_EVE-cIejSlyyI47jWn
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae842a8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=q2nx9lBKkH7kCXN1Ss8A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMSBTYWx0ZWRfX57lcjHJggt2y
 qAypLLPTPq059LAwIUz1gbLlmcHh53vAT46OI/oJM6Hrf+MP86LiTS11cPYM4gu1AIlyrDLjqRQ
 IbORw+7V7pCnRgQTqVlQeMrQivNX+w8=
X-Proofpoint-GUID: AXWQrYF4l_tlW_EVE-cIejSlyyI47jWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMSBTYWx0ZWRfX4sdW6O1p6ylm
 xH/G8YHTp4HjrwpujCUPfS+DH4DoU1I2fks0LeVmeOXmR9Lc/7EUw7zqKUnFAOcuVTexCohEXmw
 kjJihgPhQurmXQ9Zd/YoXm5sDuS6MrYae3mmbBOxVPHAKddsw3RPtTsmg8iEJ456hz3hTFjysIW
 iDcCNpaoG2TAu8VP5vUu/54fvX65WbA6UPGeLI7+1RnKwfViTh/tUzCl9AU7fgnnnWip7sw8qqQ
 1IpWd0bYt3BekrdgTR5VpxSvxJRV6EunpoNw7dXJ/5ghx19p7fxLBwOz9E8rMttoiZo+V/UdK1k
 rA7SVmNEy1oXLt8YoL/PnXlJQVuCFszNRETGRGRBIkfLjz1OEPkF/yfmuQFc66tSDo9mBLuX3Vm
 EXy8eErzpGCuFLQR9XxBdluCJTi4EPqbSV1l0fHxQxxvDIrBlte24jiHYwE4FjxKNK5rk07oNyp
 OjHOeHuiAPprObTaB/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020031

I am working on the issues and will post the next version soon.

Thanks,
Prajwal

On Wed, Oct 28, 2026 at 1:24=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 10/2/26 18:33, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 9 potential is=
sue(s) to consider:
> > - [High] watchdog: riscv_sbi_wdt: Probe returns success on MSI virtual =
IRQ failure
> > - [High] watchdog: riscv_sbi_wdt: Silent u32 overflow in timeout conver=
sion allows premature resets
> > - [High] watchdog: riscv_sbi_wdt: MSI interrupts leak and Use-After-Fre=
e on unbind
> > - [Medium] watchdog: riscv_sbi_wdt: Missing wdt->dev and parent initial=
izations
> > - [Medium] watchdog: riscv_sbi_wdt: WDIOF_PRETIMEOUT exposed without ha=
rdware support
> > - [Medium] watchdog: riscv_sbi_wdt: set_timeout fails to adjust pretime=
out
> > - [Low] watchdog: riscv_sbi_wdt: Build failure due to non-existent fwno=
de member
> > - [Low] watchdog: riscv_sbi_wdt: Missing module_exit() prevents unloadi=
ng
> > - [Low] watchdog: riscv_sbi_wdt: Build failure on configs missing GENER=
IC_MSI_IRQ
> > --
> >
>
> Please address the reported issues or explain why they do not apply.
>
> Thanks,
> Guenter
>
> > commit 5a455815a87582fc7be391ea2d8512e1bd8d0b90
> > Author: Prajwal N <prajwal.n@oss.qualcomm.com>
> >
> > drivers/watchdog: Add RISC-V SBI watchdog driver
> >
> > This commit adds support for the RISC-V SBI watchdog extension, integra=
ting
> > with the Linux watchdog framework. It configures and controls the watch=
dog
> > via standard SBI calls and optionally supports pretimeout MSIs.
> >
> >> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >> --- a/drivers/watchdog/Kconfig
> >> +++ b/drivers/watchdog/Kconfig
> > [ ... ]
> >> +config RISCV_SBI_WATCHDOG
> >> +    tristate "RISC-V SBI based Watchdog support"
> >> +    depends on RISCV_SBI
> >
> > [Severity: Low]
> > Does this configuration need a dependency on CONFIG_GENERIC_MSI_IRQ?
> >
> > Without it, the unconditional call to
> > platform_device_msi_init_and_alloc_irqs() in probe will cause a build
> > failure when that config is disabled.
> >
> >> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv=
_sbi_wdt.c
> >> new file mode 100644
> >> --- /dev/null
> >> +++ b/drivers/watchdog/riscv_sbi_wdt.c
> > [ ... ]
> >> +/* Convert second to microsecond */
> >> +static inline u32 sec_to_usec(unsigned int sec)
> >> +{
> >> +    return (u32)(sec * 1000000ULL);
> >> +}
> >
> > [Severity: High]
> > Can this silently overflow if a user with privileges configures a large
> > timeout?
> >
> > For example, setting a timeout greater than 4294 seconds overflows the =
u32
> > calculation, causing the hardware to receive an extremely short timeout
> > instead, potentially triggering an unexpected system reset.
> >
> > [ ... ]
> >> +/* Set the watchdog timeout value */
> >> +static int sbiwdt_set_timeout(struct watchdog_device *wdd, unsigned i=
nt timeout)
> >> +{
> >> +    struct sbiwdt *wdt =3D watchdog_get_drvdata(wdd);
> >> +    u32 period_usec;
> >> +    int ret;
> >> +
> >> +    period_usec =3D sec_to_usec(timeout);
> >> +
> >> +    ret =3D sbiwdt_write_attribute(SBI_WDT_PERIOD, period_usec);
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    wdt->attrs.wdt_period =3D period_usec;
> >> +    wdt->wdd.timeout =3D timeout;
> >> +
> >> +    return 0;
> >> +}
> >
> > [Severity: Medium]
> > Does this function need to adjust or validate against wdd->pretimeout?
> >
> > If a user sets a new timeout that is smaller than the current pretimeou=
t,
> > the hardware could be left in an invalid state where the notification t=
ime
> > is greater than the period time.
> >
> > [ ... ]
> >> +/* Get the watchdog timeleft before expiry */
> >> +static unsigned int sbiwdt_get_timeleft(struct watchdog_device *wdd)
> >> +{
> >> +    struct sbiwdt *wdt =3D watchdog_get_drvdata(wdd);
> >> +    unsigned int time_left_usec;
> >> +    int ret;
> >> +
> >> +    ret =3D sbiwdt_read_attribute(SBI_WDT_TIME_LEFT, &time_left_usec)=
;
> >> +    if (ret) {
> >> +            dev_err(wdt->dev, "Failed to read watchdog time left: %d\=
n", ret);
> >
> > [Severity: Medium]
> > Will this dereference an uninitialized wdt->dev pointer?
> >
> > It appears wdt->dev is never assigned during probe, which would lead to
> > obscured error logs displaying "(NULL device *)".
> >
> >> +            return 0;
> >> +    }
> >> +
> >> +    return usec_to_sec(time_left_usec);
> >> +}
> >> +
> >> +static const struct watchdog_info sbiwdt_info =3D {
> >> +    .options        =3D       WDIOF_SETTIMEOUT        |
> >> +                            WDIOF_KEEPALIVEPING     |
> >> +                            WDIOF_PRETIMEOUT        |
> >> +                            WDIOF_MAGICCLOSE,
> >
> > [Severity: Medium]
> > Should WDIOF_PRETIMEOUT only be advertised if the firmware actually
> > supports MSI capabilities?
> >
> > Statically advertising it means userspace could configure a pretimeout =
that
> > will silently never trigger on platforms without MSI support.
> >
> > [ ... ]
> >> +/* Initialize the watchdog attributes */
> >> +static int sbiwdt_init_attributes(struct sbiwdt *wdt)
> >> +{
> > [ ... ]
> >> +    /* Initialize the watchdog timeout to default value */
> >> +    timeout_usec =3D sec_to_usec(SBI_WDT_DEFAULT_TIMEOUT);
> >> +    ret =3D sbiwdt_write_attribute(SBI_WDT_PERIOD, timeout_usec);
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    wdt->attrs.wdt_period =3D timeout_usec;
> >> +    wdt->wdd.timeout =3D SBI_WDT_DEFAULT_TIMEOUT;
> >
> > [Severity: High]
> > Should wdt->wdd.max_timeout be explicitly initialized here?
> >
> > Without an upper bound set by the driver, the watchdog core defaults to=
 no
> > hardware limit, allowing large timeouts to be passed to sec_to_usec()
> > which then truncates them via integer overflow.
> >
> > [ ... ]
> >> +static int sbiwdt_probe(struct platform_device *pdev)
> >> +{
> >> +    struct sbiwdt *wdt;
> >> +    struct imsic_global_config *imsic_global;
> >> +    struct irq_domain *msi_domain;
> >> +    struct device *dev =3D &pdev->dev;
> >> +    int rc;
> >> +
> >> +    /* Allocate memory for the global watchdog structure */
> >> +    wdt =3D devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> >> +    if (!wdt)
> >> +            return -ENOMEM;
> >> +
> >> +    platform_set_drvdata(pdev, wdt);
> >> +    watchdog_set_drvdata(&wdt->wdd, wdt);
> >
> > [Severity: Medium]
> > Are we missing assignments for wdt->dev and wdt->wdd.parent here?
> >
> > Failing to set wdt->wdd.parent =3D dev breaks the sysfs hierarchy for t=
he
> > watchdog device, and missing wdt->dev =3D dev leads to the uninitialize=
d
> > pointer use observed in sbiwdt_get_timeleft().
> >
> > [ ... ]
> >> +    /* Setup MSI if the capability is available */
> >> +    if (wdt->attrs.wdt_capability & SBI_WDT_CAP_MSI_SUPPORT_MASK) {
> >> +            imsic_global =3D imsic_get_global_config();
> >> +            if (!imsic_global) {
> >> +                    dev_err(dev, "IMSIC firmware node is unavailable\=
n");
> >> +                    return -ENODEV;
> >> +            }
> >> +
> >> +            msi_domain =3D irq_find_matching_fwnode(imsic_global->fwn=
ode,
> >> +                                                    DOMAIN_BUS_PLATFO=
RM_MSI);
> >
> > [Severity: Low]
> > Does struct imsic_global_config actually have an fwnode member?
> >
> > It appears this member does not exist in the upstream struct definition=
,
> > which will cause an immediate build failure.
> >
> >> +            if (!msi_domain) {
> >> +                    dev_err(dev, "IMSIC platform MSI domain is unavai=
lable\n");
> >> +                    return -ENODEV;
> >> +            }
> >> +
> >> +            dev_set_msi_domain(&pdev->dev, msi_domain);
> >> +
> >> +            /* MSI setup*/
> >> +            rc =3D platform_device_msi_init_and_alloc_irqs(dev, 1, sb=
iwdt_msi_write);
> >
> > [Severity: High]
> > Are these MSI allocations ever cleaned up if subsequent probe steps fai=
l?
> >
> > Since this is not a device-managed function, error paths that return ea=
rly
> > will leak these interrupts.
> >
> >> +            if (rc) {
> >> +                    dev_err(dev, "Failed to allocate MSIs\n");
> >> +                    return rc;
> >> +            }
> >> +
> >> +            wdt->virq =3D msi_get_virq(dev, 0);
> >> +            if (!wdt->virq) {
> >> +                    dev_err(dev, "Failed to get MSI virtual IRQ: %d\n=
", wdt->virq);
> >> +                    return wdt->virq;
> >> +            }
> >
> > [Severity: High]
> > Will this return 0 (success) when it intends to return a failure?
> >
> > msi_get_virq() returns 0 on failure. Returning wdt->virq here falsely
> > signals a successful probe to the driver core, leaving the system silen=
tly
> > unprotected since the watchdog never fully registers.
> >
> > [ ... ]
> >> +static struct platform_driver sbiwdt_driver =3D {
> >> +    .probe  =3D sbiwdt_probe,
> >> +    .driver =3D {
> >> +                    .name =3D DRV_NAME,
> >> +    },
> >> +};
> >
> > [Severity: High]
> > Does this driver need a .remove callback to properly free the MSIs?
> >
> > Without one, unbinding the driver permanently leaks the interrupts. If =
a
> > leaked MSI triggers later, it could execute sbiwdt_msi_write() causing =
a
> > use-after-free on the released driver data.
> >
> >> +
> >> +static int __init sbiwdt_init(void)
> >> +{
> >> +    int ret;
> >> +    struct platform_device *pdev;
> >> +
> >> +    /* Probe for SBI WDT extension */
> >> +    if (sbi_spec_version < sbi_mk_version(3, 0) ||
> >> +            sbi_probe_extension(SBI_EXT_WDT) <=3D 0) {
> >> +            return -ENODEV;
> >> +    }
> >> +
> >> +    ret =3D platform_driver_register(&sbiwdt_driver);
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    pdev =3D platform_device_register_simple(DRV_NAME, -1, NULL, 0);
> >> +    if (IS_ERR(pdev)) {
> >> +            platform_driver_unregister(&sbiwdt_driver);
> >> +            return PTR_ERR(pdev);
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +late_initcall(sbiwdt_init);
> >
> > [Severity: Low]
> > Should a symmetric module_exit() routine be provided here?
> >
> > Since the driver is configured as tristate, omitting an exit function
> > prevents it from ever being unloaded via rmmod.
> >
>
