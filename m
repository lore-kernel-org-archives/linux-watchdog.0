Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AA3BBFCF
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Sep 2026 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507456; cv=none; b=qb0W218vEwth/ycH+9twA9MNfd9RoV4p/HK2Dtkd6ub4KEqAZghtIvbFUgqCOm9ZCwAjQlxNgE2MMFrVQIWh9Ffd5KkC4jqo/XFPGZuj5ABTNXqkRKKXIucn4qOi1Kko91TZbwcoVHPavU1dsOP6WcM/JUytYGNP8+UN5PEROcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507456; c=relaxed/simple;
	bh=yy3y4J7ZfHsuzJjAQbenODv7ZIpL0T92jMWOauDhI5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLapXzDuoN2A+6r1BsOfUJzwRHyYRGu/evF/CNN6pbGR2w1LyLdTqQHAzos5HiHzYyWRAEUiOV4SM0Pp50uJsVbhwg8HM+d/XVZc1EL4+zUezsWQOlPbWVQeqFsLPrzdS24TPN9acKvdJutmPy/b/UXhRie4yhqdlj11oD9rEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxO5jmp8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UEV6iBl2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxO5jmp8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UEV6iBl2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68462ZE42611844
	for <linux-watchdog@vger.kernel.org>; Fri, 4 Sep 2026 07:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CtsDQSU5VHlQkD6IyBO8zq6EWAcPowQCqqnoACC6TYk=; b=jxO5jmp8Cd17CrCW
	oBbiI+f6jxmaFnqyN/KNkUO6XyWHFZcOGyEWPgcV2jnR2f/4IarE0PaHz2MxsI4g
	npQynGCi41ZEg1NbWURD2wfqWPRGAzdoDMlEWJOYJjPPK2WtnHvoTV3RHdWPwZTM
	a/WUy/6s78IS3SCqx6bJZJpg96t/54rq9JcW/NykDteYHpITyFb9NcQJTNAdV33A
	ZF6lpqd4DLWeAG7Tn9G3w1tRp7iPI4dlwBcrMXQ0dUP9WeBivEB20HIJ8YEn//jz
	D9ybA501YqSuDYyDHAJ1DLiIVjmbmMO3hs74VVRVyqBHBw6UGBxlvhcxPjRSTKGF
	NBjwCQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtre18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 07:37:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ea38b1e7eso1810961cf.3
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788507450; x=1789112250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtsDQSU5VHlQkD6IyBO8zq6EWAcPowQCqqnoACC6TYk=;
        b=UEV6iBl28oSjkHVXPXGMK+LejcKDPieuGKp/ngEBxjMQr7lPif+QQMSRisB2ERX1r8
         KE3EYGsB1CD+63tTbzl2WlX840TAxbTDDV3ImEK9s3P1KKt7xkfpEI4auVO6Tg8HZYkn
         G8w7bOeNIRLN7txuuMaznW1swqJX7fBvc9hH41QVl/tw8Lj7Un+7/Jrn+ct0ETXxjwQD
         y6zUxcsDSU9bhVDU2Wr58lmqwix8yW4vXyEjoK6WmcDaYUuXrzaR8xyL1mSCAuRvHc2Q
         F7rkzZNoOnFg08rBtvUmf8Ro4Lc5SY8qPQ5GcRxzq7W9z5qKXJ317X36cG8ZnAuzcmYD
         tzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507450; x=1789112250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtsDQSU5VHlQkD6IyBO8zq6EWAcPowQCqqnoACC6TYk=;
        b=bDiU1x/0RssZU5Oy+af7+mgeX6crO3AucYa4ZNEeBPCilLD1/ODx62BWbwOH2Y2+47
         owdeoH57H/GOl39jfP5b3zBsK0wMvBpY6piiE4mRnuJYZLsG6nIZuwvE+jNME7LpEFmu
         DxWx+hOOPG3gGA3JpAqqSGA7IJwlmAtxxX3N6Z7KBri7vnsKohFmfh9fh2m6FkNHo9yL
         I4pu+/37hIk8s9L8tAhfrYJaHur8GgBvF5R4DxLWyd2Wy6Mks0ROAFyxGNbfGg6emApu
         iBZDsrkO3AOyinK9VUmMkwQeagKeArQGo6QLZkpV15B0RuAs425dDCm7cioUTbLXK+sd
         YK8A==
X-Forwarded-Encrypted: i=1; AKwUvByb8WF9cK9iZsRXGGbMEmLnOWXscuydtdU31JvPSPY/VB/Ay207gHi+3hJBA/z56/xloaEMqHk83zAVazSi0A==@vger.kernel.org
X-Gm-Message-State: AFuF++lSqbuRHOLWASK681YoqXkaum3HvZnEkfaxvyzFFkbmxVQmflT+
	savTC55rSvJa0RFgaYaCMeYgWehPchFY171tgFQmcfh0BiLSPGxLZkazfnbl7Aw1OX+16eaFAH7
	H4qn55p6yDlpCGiILzalh+yZy4PkRtCohjqtAlav7qcl8QaivhgNViWtQTBeiZrA0NLGOHQ==
X-Gm-Gg: AYBFou36icXwemT+kUzIjXG7JAzu1FsUerDUTVyJGl7YJytP+oYq3ClIKY2+0BFlXJn
	WraTuVtfHkBubVlQ20kZQv36eiDrMio07m23GbuLBaCbb/RZoosMhBmMO0OVg1M/7xiMKAYTRP0
	4f96GdDw4fbxzkzSCy/B8JhnVoC/Rk5WF5K1V1xzB2VYxh4QeQz682CEW1b6YqcF3lBgxY9GRGn
	3ozJ5FK96dUyIyOjxNIyaf7UeJ35sgyzVnu2O23HFopci44A+DAWBnmhjGFmi26Ezih9AthncT/
	wu+0Fn47AGfH1QhlPCqlB4bAcVD57yUGN1XCEGzlHeehXX//fHm+h4hdAGKzMfhozkfc8/xAMqM
	Tf48GYD3jHyxseqQ/MgQT0Q==
X-Received: by 2002:a05:620a:2b9c:b0:939:216c:59dd with SMTP id af79cd13be357-9398073dec9mr313333085a.4.1788507450132;
        Fri, 04 Sep 2026 00:37:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2b9c:b0:939:216c:59dd with SMTP id af79cd13be357-9398073dec9mr313331685a.4.1788507449683;
        Fri, 04 Sep 2026 00:37:29 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d559364sm67121666b.35.2026.09.04.00.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 00:37:28 -0700 (PDT)
Message-ID: <cc02e4f9-9e09-4d9a-ac9e-4e09c2402704@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 09:37:26 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] watchdog: qcom: Register pretimeout interrupt as
 NMI
To: Mayank Rungta <mrungta@google.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com>
 <3de593de-6851-4a53-8309-a6bf13e9a8f7@oss.qualcomm.com>
 <CABz7rdBv74pZe6jDRifTKRAKzGZB6L08n81_0gCqF0g=s+FEcw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CABz7rdBv74pZe6jDRifTKRAKzGZB6L08n81_0gCqF0g=s+FEcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a753a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=qgheIKeueeX6PycM51gA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: a9GPkWXa6Wsvh8v_9BMk4ci5jpJAQVii
X-Proofpoint-GUID: a9GPkWXa6Wsvh8v_9BMk4ci5jpJAQVii
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA2OSBTYWx0ZWRfX9jkUi3Hr73hn
 V6rPZ3AHIyiYAhj7WsCiHO2Jj2S1LxVkWqDdlaouxBa0oV+xIhj+pYc3WgP4ckImceNOO8ylcTD
 Jwaot2w9OyD64JJq2rNa2l0jNMSTSgQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA2OSBTYWx0ZWRfX2wALm/ivfcZU
 jzjUVCUBESd4e1BmW01+3azIq5lIabZT3FWqt8MGVvlRzyvOKyzWeF9hU5wSoj2UxD8SOhLKgSA
 k7qG4RvDff/mbBBlHXBX+BNBv1oi04zn8g9X6NkYHsjJ3No21NNWMpDV6e68wPvlgw6R4GvJyms
 NTQdFhPIvHfPs46pBcUf782mbrGyLjFqlYvCq1qAOPmJuGIFpe+LWFqAHOSazJaJlN190Mr2kZ8
 9unCJRSodwDmcVgTqGo2eTMSvRxt3VQRtWOFnHZb5KxYB45xrnRYGC8MD8IMucZczSH89wIKjia
 DTCKFo/ViQ5SrZ0NnWrrp6M9vuO9aTvfvMGHzP1Voeb6+ww1SjT+Ro4WlPvpKmvkisijKjIJzmW
 tMPzC3Ixb9a7SUDzUWuWZqHPDjWE5SpeQCwPrmLyHL2JOgw/LmMT8ZdT7bdtzwSt/6E5x2tDvTS
 dVQNGREQJ5B1S9IoDZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040069

On 9/3/26 10:58 PM, Mayank Rungta wrote:
> Hi,
> 
>>> When a system is completely unresponsive due to an interrupt storm or
>>> deadlocked CPU cores with standard interrupts disabled, a standard
>>> watchdog pretimeout bark interrupt will fail to execute, preventing the
>>> pretimeout governor from capturing CPU backtraces before the hardware
>>> reset bite.
>>
>> [...]
>>
>>> -                     ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>>> -                                            "wdt_bark", &wdt->wdd);
>>> -                     if (ret)
>>> -                             return ret;
>>> +                     wdt->irq = irq;
>>> +                     irq_flags = IRQF_PERCPU | IRQF_NOBALANCING |
>>> +                                 IRQF_NO_AUTOEN | IRQF_NO_THREAD;
>>> +
>>> +                     ret = request_nmi(irq, qcom_wdt_isr, irq_flags,
>>> +                                       "wdt_bark", &wdt->wdd);
>>> +                     if (ret) {
>>> +                             /* Fallback to normal interrupt if NMI not supported */
>>> +                             ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>>> +                                                    "wdt_bark", &wdt->wdd);
>>
>> GPT noticed this IRQ is requested but never enabled (NO_AUTOEN)
> 
> For the NMI path: request_nmi() requires IRQF_NO_AUTOEN. To balance
> this, enable_nmi(irq) is called immediately upon successful
> registration in the probe function:
> 
> For the IRQ fallback: devm_request_irq() passes 0 (not irq_flags). In

Yes, you're right. Both GPT and I were fooled!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
