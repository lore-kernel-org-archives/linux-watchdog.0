Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F43E9F76
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785498997; cv=none; b=trBbyXRtZjqY19LDz//MvP4vyS5gEkrFPSMGzlmPM0wqF91YTBKY5iY6Ttxfj9W4OzFiOHpFW0x6i+ugKqTy1Lg8Mu5SzEpxsz2GkmLpGOXtMGf/3mlO4GkYjxlYS9CJL9cwZZz5ZRXItAFa6IA6UBpLSncrBc5nI/1wJKlTwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785498997; c=relaxed/simple;
	bh=WLU4r5g1L2R6YbUlpp/0jjkooXm6on4bOd7pGMtkBow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrRNA//Jm+l5Mba7g6ACX4SpmWX7O3KaBJBD9CpnbU6XonJTKCvlLuIpAeqhLxXH0pr7EGUsc2KTvf70AeCwR+mDBxrSh6axLUR+oPqUGtBtbd6WyNfF1BApvTgg/AeDZtCZRQm6GAV/c8Ustk6po73MoS56NBK0Xe88WdBPiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nHxERBJl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DEJUvIdR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHxERBJl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DEJUvIdR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBgl7R3797983
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 11:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JmvNUqLdYeomxQuQ2aCdM4gJYixDdHuUmeKKY1QoqWs=; b=nHxERBJlkO15Ziie
	BC/cZindb6UJv5Zk+1d+s79nIIukA2CgJ7lbiMnV3XIBeSTI7zTL/bOjwOExWQF2
	VCLE+GhGlJvtqYoaI66m8xt4kpX1lk41AryLEhdyTFu/aeLG5RGvNB/1NyhcCzOV
	XASalIH9fL8JPh2DS8HwJYsg61DxDv9xcmtO+MVuEp3nKUPV+fjGK9RgqrBJaodq
	qb+bIOw5CvsipXKc7rLMWzuqypLfXOiIfIqja+u/4wlHX75F0sXMKSNzkxjvYc95
	qHcJqL+rHFyCujyupQYz9CGB6y3igMNzeUQTJ+XtiGNBIbpGHuY8pIsUT3nMFRlQ
	25xJew==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru2u01d1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 11:56:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52845bd815bso1745801cf.0
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785498995; x=1786103795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JmvNUqLdYeomxQuQ2aCdM4gJYixDdHuUmeKKY1QoqWs=;
        b=DEJUvIdRv1GjuIezCG/OTzt/hCt4TNrWe3V0Bl1Z1o3JGReaFKjHSwhFPZM60k5Ful
         VH+aYENXvwkj3H1uh8Rqm7uaI47cKyhw8BL9o+GYdZTwWzNqdpwMw+1g5VASWP5OCNNz
         MquXRlJ7WRBtIVDXW9tbSppCAtNdHiPxl5E/1tZocoVPtlfHKJJcGrv7F3Dnlwuq+/0L
         0xiPMD1V/PDPQ2eW8Pj3qz6vMLPo9s5xpzyDvu4sWfUVljJyUXREN3hDrpBEeexdhmIp
         PsSnugEG6YKBDsFEddfbOR0d8bcGE1oTyRHQmcR8UzHVUdUeFw3ocCmpOfnxlQWWRqC1
         5XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785498995; x=1786103795;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JmvNUqLdYeomxQuQ2aCdM4gJYixDdHuUmeKKY1QoqWs=;
        b=JmoFq96R7IC4Bzo+nh5R6FBYIBUxDHwbJ9UXITS0hhkujBmdFQjTnxfcPK6lVvo+pd
         /xn5XQXZDSdb1JwHvuzn9b5TW9GVWKgmp6gtoyWx0lDle5+OJ8dqzOkNmgJGOj79FEA5
         bWrbxxpl7IspAOVFcc536jVUxnExjSuNdw+m5Dnw0nt4s9RdCVmX5yVXA4defGeaKWpV
         8nXTa+lXJeAQCfyAK0fnwqHzqL4BBvay/AG3Brz3gZKNt6bQTJdkTqrCV31l2TXIByB8
         iLu1r+YLgyJurOACKP0534klvJm1Bhihj4XUeQFYznOqtCPaDPEOSJ2K6syZD+v4e9lD
         B0TA==
X-Gm-Message-State: AOJu0Yw0uxsPH1mP3inFMO8E/r8676aXOxZizFvw348xMTflIPYLzxsC
	pjNCV/0stT6ELYBV7dDWenjEk2YBUUpeBSxBJHZQPeN2wH1lJf7ExwxMct1t+NjyYcsCWhS0DeZ
	1BuG5tGXoMvuuHj8Ky6cyEVrtg9e6eqHi/3dbtubaOfqYuL8GTNMJUblHosi4yZ5hgxflsg==
X-Gm-Gg: AR+sD10/AweJvWuXuEDkxHA5qUF1Fz5UcooDCmSC4GSzr3Gv1GHrfHq9QXgKfzgecx2
	YKZUUqVqaIPL2Fg3m0E/P9NUTNwuoVJt1IjCWbBd/VO7vMBRB0aSloWB533iqShKbIeApPZR2Nm
	gZPvK074EJaDQg2I6U/QKv2v2r7sLPvS2K8BImZtA3AFXq5/KNx0w2+orWkVHf+3nNzRJIo8n2l
	RuBl41rQ5oNVFPufjKvCwdtBys5ZjPgI9P6Q2g6neq1M/A9fZHkFbAGqlS/2fNviI0AriB3nDTN
	cIJxNiI3s8BjXObCI0s21NcH9RzZynsQMZ/nEInvq0zMujJR1L0uuo+rjMX3N/LkVTjp99yPGg/
	f21Hkgc/hX9AkQAlJdhcEbqtD
X-Received: by 2002:ac8:7e81:0:b0:51c:1c73:51a6 with SMTP id d75a77b69052e-52b4b12c2famr20189821cf.5.1785498994683;
        Fri, 31 Jul 2026 04:56:34 -0700 (PDT)
X-Received: by 2002:ac8:7e81:0:b0:51c:1c73:51a6 with SMTP id d75a77b69052e-52b4b12c2famr20189521cf.5.1785498994273;
        Fri, 31 Jul 2026 04:56:34 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537702sm123113566b.53.2026.07.31.04.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 04:56:33 -0700 (PDT)
Message-ID: <36a7bd8e-7e00-4df0-abd4-e22b86e91ca4@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 13:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] watchdog: qcom: Register pretimeout interrupt as NMI
To: mrungta@google.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Mrm4gdpz8l1O-HgzGeqcRyPzvYg5kqg0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5MSBTYWx0ZWRfX8IG1D7F9xWf5
 P+3Ij8VJIyDGaLJrMhBsltMYAMPhrAMeRmSxai3AwFICyuFhBjPU43IvLsmxOHl+ycQdC8pg1Yz
 QcOEAeLKHWvYuxkBcjLK5Wx5q50AGd7IgUfrrHys24r2WnIswQIZQeHa+evpxgzllfAi/BTRZPj
 jLYRD8MsORyBrGf1cGN34IDQ9jBrywgsS0YcOp5QppI7jx7JmefHqASRdit24zwUU8gr28ZmnX7
 8hwRcUvVMtxRGNGr/UMsaIm0a+9mycBC2BSsQttHukrZe7XBgjeXoJZhSQVU1IUsxSBA9dlQIXi
 OBm+y3L1J/guMgmxDcYs9/5WY2wwlI4u+AoM+MEuBUexc7G5ZGbrMfJNg74+qf8y6tANW4u4hQu
 OzDemkNnYU9uoC1w3en4HQ2CMNnJnPCUYNneXfcc7iFQreKlj34tn6NPCk0W5vluSz8h7xCzU5L
 v5pDlmNrLygnB4pPwvg==
X-Proofpoint-GUID: Mrm4gdpz8l1O-HgzGeqcRyPzvYg5kqg0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5MSBTYWx0ZWRfX57arO3TWptV2
 fCeJtcRl0Wb47Ia3vJn202OLZV7ge6aUnIxbkHGmWteWlP/JTm094Rjz1YXyYKBDTP+qyrhwqb4
 V6AwEv5NvuIP9gnqcdKQUfdOrQfeVQg=
X-Authority-Analysis: v=2.4 cv=b+uCJNGx c=1 sm=1 tr=0 ts=6a6c8d73 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1XWaLZrsAAAA:8 a=knYzKYFgTjH3_HfYCsAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310091

On 7/30/26 11:32 PM, Mayank Rungta via B4 Relay wrote:
> From: Mayank Rungta <mrungta@google.com>
> 
> When a system is completely unresponsive due to an interrupt storm or
> deadlocked CPU cores with standard interrupts disabled, a standard watchdog
> pretimeout bark interrupt will fail to execute, preventing the pretimeout
> governor from capturing CPU backtraces before the hardware reset bite.

[...]

>  drivers/watchdog/qcom-wdt.c | 55 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 49bd04841f0c..19d8e91cff40 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -51,6 +51,9 @@ struct qcom_wdt {
>  	unsigned long		rate;
>  	void __iomem		*base;
>  	const u32		*layout;
> +	int			irq;
> +	bool			is_nmi;
> +	bool			irq_enabled;

Do we need to track this? I think we can rely on the framework
NOPing out multiple ops->start requests

Konrad
