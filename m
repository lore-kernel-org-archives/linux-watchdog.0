Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182662E285C
	for <linux-watchdog@vger.kernel.org>; Fri,  9 Oct 2026 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791508034; cv=none; b=qvUonM/HRPw2OKBaawuhx8APhY+lunzcX49RqYA/icHTy1URLxovzU9CTjbRZvh3vnYWtcc71B6LNiZctWyk9Ea3DP9LtN/p2wQKOdYQI4WTZmIlv1lkNeX7jA+uxhZ+OayOsXYhfIUnM4zHAnxPoJdapr4rg1V4dVYU3xZMBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791508034; c=relaxed/simple;
	bh=+zxnZvtNeGJCI7pCdIuW6g2eA8/O+svbTTvlPCXqKk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9ltqy/kpF3GgcST8nzTSiOvAyOLIGUt3PUXXz3Vxh/3pvKaO9iHSFDK7epAkXg51iChU1sX6qKVrfMCW4eDGE0Tu+b2M9I0nvjIc7pgqCf2JucLF0KOiEdwPO0T/Jdd7F8bVT958EvQwp0Sq7o6z2DKEcY0Za7IWrcj8wF8JNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PMGxK/nK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T9zbul6p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMGxK/nK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T9zbul6p"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6990R41D725987
	for <linux-watchdog@vger.kernel.org>; Fri, 9 Oct 2026 01:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wv5XRzDrzOa11d81nPhympfz8h9JIRXzef2dzjWca7E=; b=PMGxK/nKr79j6k8B
	Nr9SyWFaowRNIeabOmWzTuVixody79Vtvmi0+ZgmaLygg2K9sEqr3cHep9ZXWbL0
	w2XYoL9N4cZIKUn4de5TMIh1W5KLf03/m0OgcBUKMXQg0sKbqvZPEmuXbMzO0LO+
	nVfxxUXkBYdX6QqqFr3qjl7Haa6q9H+jIxibJMwaaDy9/LyXo85HaMGS62ySJDUn
	gtWdUXxU9rVh64gSC9mLRu8yrVH2fXyTBwPaBXpN9WkRrTu11SiDu8DNOUehek/k
	OFcIvVK+zLP1pxU675bp3+mktldb+y3OiOEJ3v33VtClC65T35BpZ5j64Sa4EapH
	cyjToQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekv9k2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 09 Oct 2026 01:07:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34e676375d9so5890846eec.0
        for <linux-watchdog@vger.kernel.org>; Thu, 08 Oct 2026 18:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791508031; x=1792112831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wv5XRzDrzOa11d81nPhympfz8h9JIRXzef2dzjWca7E=;
        b=T9zbul6pTaE2pvbiGT7BrNWNkzayD+1/ZVNTxHQoPaL/bBQKNdB8JG4DJvp5RKEAVG
         hk5uR8HMW3yHZychZvrpuILZF+aNFI2YykqplLEvptI/0KRTEMsz5M83TO9mqiK6owb5
         /TI0koH5oRZokcqlHPPLMMBL1i5Xj50/xqMLegyx24BXiTpg3IaiNLRiwtYhGp9nQK3e
         ITGH4eiVP+j/7q8NyV9c/FcBF3TfXFSycbT7g6rhr3VmEgpaEevm4Ny0zyLqx2PyttfX
         GyO7k5sxHFbT3/+dLI0C3H0PfJW3nm4rgtz6/rcoxSzg8mBj8rFR2w2Hb1It1a4aT+SG
         MnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791508031; x=1792112831;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wv5XRzDrzOa11d81nPhympfz8h9JIRXzef2dzjWca7E=;
        b=2K/HF1s+sxy4kY5Nl+inbwf9fkuV/WLdXuwjKmQByLEkPKbC0h4dgstnySDBjsjaR/
         tzmypWj47yxpPGBLkLx4GGfDmDgwYE7RZ2I29JPno1ZcTKHlIT/Bl3pblag0eE/c8v0P
         KBNmvBtwDCumv9QnXHgiQYBeuBbYoBbFIRE9TST5OA0R67Cphdo3XSWsI4b+rOWLMIe+
         xtSHhH/AoFnqePQ1Bg5uYDqeo9TrFsdAV/a+HNQ4PX2b7+rOSfjqB7dgCbAeFZ0q+h18
         hCannB8emxOmU1EvteXQarJZvNWzkOCGvr3L7nD6JaIny+yqQafob1AnoHxcNVRCveFT
         IMVg==
X-Forwarded-Encrypted: i=1; AKwUvByoRAXNNxaA32uoyPR75Y6sVlC7cEPL+oVLJYB7l5ErDcmjwuNzSbdJwG3dr3wWWkTsGXBoLTP6WQLmkU640A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJllmWd0aMWAe4o8kRxeRQVjB/dr2cWTLz6zV2oIDbjsqbqlWlX
	F5g6q71hv/siuvjba9aXLl2Nop+2P7+PpE3mMz4uVTu+pkrej/1KSSh++WP0E2zKXxHy41AXITD
	hlwZqDB8X8w/gsSBk5tvjttuef1SanNrBpNpeXbodvozHHOqx9xuCiDCwBly0ojJn3QG8u8z7yb
	IerA==
X-Gm-Gg: AYBFou1UJ85AxkLmUfljuR59AhvlLlJV/vaO+rVw4zCcKKSNT5uZr7OIKIFAx3C/fBh
	EVHohQzSDzzG5AJ+tTun2RPwTt6HY6Uuc6YlnZ1Ajslaa6aH1YkQjt2875t6CPI9ZGRYodGC50b
	V8DY19fx9vKPi20qz/XEDxXlY5Cj0DDzoZM+fAbSIzphM0YpU0d5TXO5HhYV4z/KqgyckP2Dndg
	JRZiLmkWMw/Fk3j0yeQZal4lylxyZsfX0+KQ+aMymSQvrIryoQIrZlf8oyYHgk2g16+Cye36Zvx
	Fy8Lfrxx/FVd/jfYvDdG6vcNfOlijopNrBJIkRm27SGrtSS+QtPQItw14YX/7bGcqAor9WwwqvR
	UQR+GNRZstZ5+SyfZDrjLpsJI7UlFh7B9GiH/kq94oZV23hSHkH7z
X-Received: by 2002:a05:7300:c8c5:b0:34c:6edc:f4d with SMTP id 5a478bee46e88-3537de061f1mr790415eec.1.1791508030275;
        Thu, 08 Oct 2026 18:07:10 -0700 (PDT)
X-Received: by 2002:a05:7300:c8c5:b0:34c:6edc:f4d with SMTP id 5a478bee46e88-3537de061f1mr790363eec.1.1791508029119;
        Thu, 08 Oct 2026 18:07:09 -0700 (PDT)
Received: from [10.73.232.100] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e05esm1795163eec.25.2026.10.08.18.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 18:07:08 -0700 (PDT)
Message-ID: <ec393b82-912e-4f85-8f30-b3b8cbe948b9@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 18:07:07 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: gunyah: report system sleep operation failures
To: Zhang Jiaxi <Z1529105815@outlook.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SY5PR01MB10600A249F7E2CAE647EFD46FA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <SY5PR01MB10600A249F7E2CAE647EFD46FA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KrOtULZ2ZqtTtpiJNhmdGv6HwJg4mnh7
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac83e3f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=cNoKYFeJyS4W4/1HdvzxLidmn8o=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=UqCG9HQmAAAA:8 a=wiQ79f7mt1jt9let52sA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNCBTYWx0ZWRfX5x5n/126eRAi
 XVOBdmYwN+G2l5t5GRNceVKVrl0GRitFXzxKbg1zW5z49qvTrT4RB2iQ6jEvTXeiXoYBqE6v16Z
 Sl98beWHrKBqLfsu9XB22J+w5/LTkD1G0hpz2XNpkCH6HkJH7BwPhytul80AeJftIHLt26PbSdO
 dkO2asaGT5R9a2/vWA1g/UIbv1ybCDvU8g8rTzTkOVX670lH4ya6fy/Lt6jpDC3SqVuzth0XBAo
 02ywAv38GTGrMbybI6Fr90ttg6a8d2obJUjR+pi3Ojy9xsLL2rlzE48Rw/1xOASgNY/waGBi7+E
 QDCoSDDpQkMMDChjTmD58wot/NrB3MYXkk9Yb1658AfgdN9VbCsFmkd6XLBViagNLRlJ/+RdA2p
 EQ9hY11aZrnh4qYibWR7MHUv9lllGIIXU+xkRyHQdeIje6M96dtbBoqWnzNig9zBxH59KZ5FXWP
 Ylqu99XZHlxu5kpMWOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNCBTYWx0ZWRfXxcxRW8X3TaxS
 gwFnrPD45UsB8hMBlmBGZUVJ4tRmTJnGUPTBgBDQDojJeqYJtaJIifFStXxBhF7CD13Okuusx11
 Sw2Y2LVc04X6iIQxF4me62PT5vmbQFQ=
X-Proofpoint-GUID: KrOtULZ2ZqtTtpiJNhmdGv6HwJg4mnh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090004

On 10/8/2026 3:34 PM, Zhang Jiaxi wrote:
> From: Jiaxi Zhang <z1529105815@outlook.com>
> 
> The system-sleep callbacks discard the errors returned by the watchdog
> start and stop operations and always report success. If stopping an
> active watchdog fails, the PM core can proceed to suspend while the
> watchdog is still counting. Failed restart on resume is also hidden from
> the PM core's callback error reporting.
> 
> Return the existing operation result when the watchdog is active. Keep
> inactive callbacks as no-ops. The start/stop command sequence, initial
> activation exception, probe registration and last-resort restart behavior
> are unchanged. Reporting a resume error does not implement recovery or
> guarantee that watchdog protection has been restored.
> 
> Signed-off-by: Jiaxi Zhang <z1529105815@outlook.com>

I see flurry of emails from you. What exactly are you testing here? Is this driven
through LLM? 

Please also fix your SOB line. 

> ---
> Clang 22.1.8 compiled the changed object on torvalds/linux
> 6c377d19d4a5116d9bec5203aa3c6c11523e7898 without diagnostics.
> Actual callback tests with modeled start/stop returns cover error propagation
> and inactive no-ops, including old-code negatives. No device PM or real
> hypervisor-error injection is claimed.
> 
>  drivers/watchdog/gunyah_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/gunyah_wdt.c b/drivers/watchdog/gunyah_wdt.c
> --- a/drivers/watchdog/gunyah_wdt.c
> +++ b/drivers/watchdog/gunyah_wdt.c
> @@ -214,7 +214,7 @@
>  	struct watchdog_device *wdd = dev_get_drvdata(dev);
>  
>  	if (watchdog_active(wdd))
> -		gunyah_wdt_stop(wdd);
> +		return gunyah_wdt_stop(wdd);
>  
>  	return 0;
>  }
> @@ -224,7 +224,7 @@
>  	struct watchdog_device *wdd = dev_get_drvdata(dev);
>  
>  	if (watchdog_active(wdd))
> -		gunyah_wdt_start(wdd);
> +		return gunyah_wdt_start(wdd);
>  
>  	return 0;
>  }
> 

