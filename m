Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE5332EBB
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423500; cv=none; b=bflZkOFi13uHM1URs774s/jEwn6GOax02lHTudX/N49kufMasLN14Zm5NyFcN4ezKteme4ndUCJNmHEml3lQreee9lR6JEFRsvYAiEicEZT1nY1S7arRhdqs1dI308aQ+bnphEO67RwIucqG2cijzXMv8si5iaZ+7CQEQw9GVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423500; c=relaxed/simple;
	bh=OJPoONQm/fqzkmqO5WFzMXs6fGooqSq3sNVBu7SNsXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLE7JCw/oMCcjoZLpSOM/TBWSAyFmKR4KsTmn2GfwmeaC5itCMuSE2P9C87oO8Ty+lfnKwjjP48z6aoaYi7lxLSsZ/HITOCefbliLiVcKzVLhJ7jj04UOyRtLI363vHji979Yv6jeUIDnqgDM/L4Xn2Xq+QhBgIQrR93F+WY7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=brEbegD6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZoX00u/o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="brEbegD6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZoX00u/o"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835leIP079891
	for <linux-watchdog@vger.kernel.org>; Thu, 3 Sep 2026 08:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7q3lzG40vOdDQkotL1Pw6mndO2bNuNBDqu1ukd2D0yA=; b=brEbegD6nvOBG7mn
	0y9YvRaLwW43cRv7CmQzXnnSm/kOphpDtKMSj6dz8a8izdanE6fxFGifYjM+YAG2
	fuxMFxaYuuI0kX11qv6HFeJXEk7paY2LG9QEHI/jkTEiLu8RKkeNRHdWyDBS9d+i
	tvSq8aIFlrWFOdA0b4K0tKUB4IHHiAlk1CMx1vMbHzbdZZO5clwlKBkGaRJb0sL0
	OqCEaFXNP2G2fCfzCAhvESBJeabk4ycF2nRM74jSA/TCRp4L2ehzhag09oa06Wgj
	gG6lKSWNOpHbxa9QxaiEEUPxqvpJ6KmvMLyAeU+WbY5VilwXOI9tLjlKzo3A3Ufe
	Ha6Z1Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4gvvg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Thu, 03 Sep 2026 08:18:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930bd2bfc45so60323985a.1
        for <linux-watchdog@vger.kernel.org>; Thu, 03 Sep 2026 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788423497; x=1789028297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7q3lzG40vOdDQkotL1Pw6mndO2bNuNBDqu1ukd2D0yA=;
        b=ZoX00u/oAaXZ/iiXb3Nnf2xi3iHcQb1DLamxD3PuwcydvAYK10RbjoXd5BSLlumvIw
         F4NozyyU6fWxHZz+UCizJHRdxivadP/OdXb1r3Ph250zLM2nTH1CSXZiworYJgOS8LW7
         wt7OhXaat3O4gxC42tohChna8EfObK+EkQYLg0ZsvMFlfr/24628hulHXBF+2XhDZ/5e
         09kZjtgIu3y9or1I2N4MSe/TaOLqBR3EPn1/D7PUgDd+TkWSNE24u0QPF3UJc5d9o17a
         lReJm25ufZH4Z6YXNIeRVF1E+6ZeAGVwHXz6OSC3iVPgh5D5Ihw4gIyYQvRgJzsDxzbo
         jdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423497; x=1789028297;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7q3lzG40vOdDQkotL1Pw6mndO2bNuNBDqu1ukd2D0yA=;
        b=iG5mRaxJUHhTtxWEtqME/ewY4dAGQp/hZ0EM8ct3h198w3e7VlUrz1FTXRMXmKArUJ
         lJiZ0N7ztxN8IwIBEHtgSJj+w2Sf9zY0YXnV2cDrtdIYn3K8zn5ZILscxet7DqG5OObG
         fQBkx8suAACQtLu75llbpJeUeQwVmMlUAoJ0Ellgu8tp7qyqqb4W1W70+COqkMdY8ebG
         uRySJ/hH8/blL44/84KquV3gRLaFVGyvJZYGAzDMjXNCRqYlpGwZPgTNNdKVzSH6a+X2
         O4w1RO814ysC8E9h4ZFR9dXSipo4nifw34wY9GVojjpeB/Ej1HcbQzrI9+wWR6C3dx0d
         P3KQ==
X-Gm-Message-State: AFuF++l+R8vq5DiAzvI/u1hjDw09DZ04WbzCr4NTiE7nU1L/sbt8Ti7U
	TYJXfnbuOJKYv8UoCJJljX9MP1UKXt1pO7QCZqXBM511T5MQanKeEOPnqTZFSHSf1bk/zPpdytA
	IxVqY42OcZaYxmAsxRKVC43v300SoHZx0SgL5OSH5W/fheT0QB6YDCXOetYe0/F6aAjx51g==
X-Gm-Gg: AYBFou1QfAzYeHi9i8BXHYPswlapYY0SImudw4wY2yOGlRdaTjG/HDUQ3qMrmf63M4X
	aQQbnnJB4nidJA9klfQkocQqLynAqEIZcnYRK8lOKdFI0IHxM+ke4POqOvLuQ2FqXDBEnRCEOEN
	1Xx8tqYLhySByGAoum7gj5m/ZBr9wAXdTXs9nZItNKktwweQ/FaXKg+FCaxnu0HtvADTPPbOYpE
	5nbcVKCwPHfm2UnjtvYRxPTytKfOgQvjuZ9sI26/KWthgpoG2cuJWmn8nPidx0hWZvfvhIRQOgb
	+5s7Ec5gSoZWAK1xQWaYNA5sTYB0+SVNR0yD+1VLLqWvZEZAvqomjw8GAgPT+wJ6nxXCWRpx5km
	QhIDLWC7WscnFsRiN9r0GoA==
X-Received: by 2002:a05:620a:2622:b0:936:6e2f:a34d with SMTP id af79cd13be357-93960faf11fmr778710585a.3.1788423497592;
        Thu, 03 Sep 2026 01:18:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2622:b0:936:6e2f:a34d with SMTP id af79cd13be357-93960faf11fmr778708285a.3.1788423497214;
        Thu, 03 Sep 2026 01:18:17 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f6c2a8f6sm50161266b.35.2026.09.03.01.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:18:16 -0700 (PDT)
Message-ID: <3de593de-6851-4a53-8309-a6bf13e9a8f7@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 10:18:14 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] watchdog: qcom: Register pretimeout interrupt as
 NMI
To: Mayank Rungta <mrungta@google.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a992d4a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=9ANM9Gnv0aYF1O8oay4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Bf5wlNzzOXLb0LFiUpDsk1OxnXE5s5t1
X-Proofpoint-ORIG-GUID: Bf5wlNzzOXLb0LFiUpDsk1OxnXE5s5t1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfXyPOQ6H/a3PoW
 DryxeUrsrwlCsOG7vI1o+GKNt+CN2QsSXL7JEwFYhR0/tYDITe3u1PjmbuMr08ffcwHeAbaiiAb
 iwkWdUyg30+Wbr1ucfp1qdmLk+lZxfo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX3nN8kbOMogsA
 yTy5PiqbvEVQTckexW9Ue1FwkJ5/ZbeT0tzIeus0FCWg3RQ/lT6q/6LL+eJN8O3+6ncIc/bRaKm
 8DtntM9He7yh6CCznP9uHf49JfXceURMZrdV51B4gyMesYmfzIs5Kw+NhpOdJVshB+DHAUIfuL+
 1Vd+2OEKQHDsYF/CnxtXkCjpg64Ox2RQ2/3zs8UegmcowJgDWptNfZi0UP3JZZgyuYXMdE0gY7U
 KdHrFqQbM9863YVkkM6l2gxKJs5GneAS4CmyRCHNfkvvOOfKbY2nS3Med6HLisgWOYig/vNNewL
 htIaYHx50P2bmEvK5U3FMQ+7xYCNrT3JhcMWf9UXcKKWp/YXq0Id3bBZqSCHbkwiqfntrqpBw0X
 o5uHxYJ1Z0Y17fB6kOf9EYctadNGpG21mibCa6hzvWKRODTDpmCKrE/OI+5aZFDAlSl7MCmPhHF
 BxLDvr6DV6/HZ6pwyng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030073

On 9/3/26 3:54 AM, Mayank Rungta wrote:
> When a system is completely unresponsive due to an interrupt storm or
> deadlocked CPU cores with standard interrupts disabled, a standard
> watchdog pretimeout bark interrupt will fail to execute, preventing the
> pretimeout governor from capturing CPU backtraces before the hardware
> reset bite.

[...]

> -			ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
> -					       "wdt_bark", &wdt->wdd);
> -			if (ret)
> -				return ret;
> +			wdt->irq = irq;
> +			irq_flags = IRQF_PERCPU | IRQF_NOBALANCING |
> +				    IRQF_NO_AUTOEN | IRQF_NO_THREAD;
> +
> +			ret = request_nmi(irq, qcom_wdt_isr, irq_flags,
> +					  "wdt_bark", &wdt->wdd);
> +			if (ret) {
> +				/* Fallback to normal interrupt if NMI not supported */
> +				ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
> +						       "wdt_bark", &wdt->wdd);

GPT noticed this IRQ is requested but never enabled (NO_AUTOEN)

Konrad
