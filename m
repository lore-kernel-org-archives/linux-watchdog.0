Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF93FF1A5
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900926; cv=none; b=pGbdZLe2H736CK/X5xWEAVJ8vFBQCtjDDlEbzwFqTFYzrbh6nVnM85fFOkpoBdyb7LkeJDnFKMYGpYLOrz+zo0EZgupIOn9t5nhKkVxrtOlL9mFP7c7Snk+iqT6LxjZVy/hyRx04i8xIWFoSKiSWfwnD17nY6pKWrPfHj+7FiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900926; c=relaxed/simple;
	bh=Emg+OkO7QBbwSBpYFEASaSwaBOIaLaMY76HkNKUceGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O88CHMZLq0pz2y9AGvYvxp+4du58fnmTlepf0kp6W+CsZvlJJ0+StWDT+GZvsdW6hrSenJSrNTsXtK0nYF38a5281RYyzwnw4PB54v7/loAJs6Sj3UHwrfapQsDqk0P9asHf8uJ8vjedFxelY7N7kRG6Ba4dARwgQLlsESs96S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G/e4UX8j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=biUZuMu7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G/e4UX8j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="biUZuMu7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE43m9900319
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 14:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8CZVWM1ZfL+i9RUyAbx4kRYDFvtGE4TrDaWJXNG16OM=; b=G/e4UX8jRVF2CpHC
	3h4jFPZQKwnXFfvPH5dPqHXMEZjfKy8EBn02dcvJWCpVNFCEdL/pFB3+5X2bPnbA
	tPfu2lfX3WKYlRmJ4GEu0aHSA/ga9IQCrv0P8aP4V7+1fEMCasaf2NV5qPjMXB2L
	2RnkX+hS75GecZ2Ck9RtBZZXb6uFqcIrOttYGowalTg+UeGwHm8Bi/RrHtGuUPVE
	FvwYXUR0fk8fJGQ0uNgSlfqPVESqmB9WZ4jztgVNQH+JW+oLAuXydN2k9R4jzVdf
	aeTF8FS0O+Z0vjmQ2A1ltiNdc1pdxBX4TXRZRTmuzjXDqPFrO2msiJ+KN+ad/63g
	wtQGiA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7uhp6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 14:15:24 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7c1fd351530so76091137.1
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791900924; x=1792505724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CZVWM1ZfL+i9RUyAbx4kRYDFvtGE4TrDaWJXNG16OM=;
        b=biUZuMu7O7MLxnEbkBkDZzk7cnP+85qIRD14NsVEVcu3etTmUDcGIb4Oisbu+XbzlK
         Vfowls7itgCLQ/6nKORILduHuwmzv7BUEOA4CApPq7MH13v+HDt/30/EwlSxU481P6h0
         N1b+5Ek8CWLEuTPyVHIINWHcTbELQOp5edVzp++PYdvHNdk6QVzIfze/VVirmfCxJByV
         CDE3cZRyeT61kD0r6j3vfWJedTX8ja1RG6YbUINrqOrzeEfgKgqFPK3NBqwMGR1vItMd
         Htxs2qT2z5o0nH31XiEY6IvxxE0gOp/6dKo/iO3uxcXgufdwVCr6P9pjzjBRxGS4/986
         8pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900924; x=1792505724;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CZVWM1ZfL+i9RUyAbx4kRYDFvtGE4TrDaWJXNG16OM=;
        b=EAphrzYUlW2F/Rn8DNWl22YFa6bVnQ4AZfbG7w4/+Focy65/Emsl/0BfPNAnitqUwg
         OTRqbJgObVjmnwaIB9EDMW1vsWsfEEo+jQipeAeBhtBFRtc8QtUuIWPelwXXE+NGcTq5
         LeToP9e6vboe60ioxoOvknBqZUPleGDRBt6qdT1UUaDpUqxq1cP+Gpm36uw8vPV6PWHm
         xHwXbqwtDGfEGM6spFkXSjKYdD2HOM6c6E40hwuYapOEuItcVxELZBXa5NvJQCkhagut
         f/MHGCPlqT/EG9n65ju4/AXi1LN9jjG201e8WRRpnlFhUrdwLoXYrDjZBx+Dtmpb28XQ
         /9Ng==
X-Forwarded-Encrypted: i=1; AKwUvBwZ5mKTPWQtKfEhp+KOyA7hQnmQBARWqkamjHG4rphYutlNHdiBta/snXJyqFGV+yWdo3f6KVA6mJ1Q6tjlrw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdQAaI5Q/0wD861BSobzmecacB8i130LsUpRi7z3YWJz39vH6b
	z/tBfA7ZZV67Jmm853IbmdFp+o/nfoqOxzJT4XkXFXoZGCzGu2SPalJJbFMmtGpFBoXaKaWiS/j
	jUjDkJ9qSN4TyxR3fWyhODRlq5aM7FHx7S1q+1U57mD7yL6esNfopELDaeu88AU3INWtRwg==
X-Gm-Gg: AYBFou3h26XBHft3bjcy1Xv5eBMka7f5uyddrNv7nQb4G1lr+K9m6CFX49II+xhHVk7
	0v/k6jt0DqsmM3krMjCcxSr8W8Q5oxdveC/OKQKirR/KG3xT2+i8sqgaZkZqLU7wn2b0c3dGJdR
	U5Wf9k/6/fpiiRRXOWM0gpqMOqhRr0UO/PDNIugWW8H3e9PNFtG/Gjjd4fJy23fMVqW09vCL/e7
	6h6xvuiqS47XDlH27mj+Rx1/CQqZWb+dq6SQfvIyi+V3OoQtxSIFrp31xfpdPCUsC2L6coWYlsf
	A5BQCB8temr9Odht0h9HWSLJloMs/SeoZqJDh/12NQdSMtIMUbrOPj5pR4xuJoQJbdLlDjRipxm
	CiHsegtjHGzMz2l27zI9McQ==
X-Received: by 2002:a05:6122:8711:b0:5e6:6546:84c7 with SMTP id 71dfb90a1353d-5e91f339ea0mr2872715e0c.2.1791900923853;
        Tue, 13 Oct 2026 07:15:23 -0700 (PDT)
X-Received: by 2002:a05:6122:8711:b0:5e6:6546:84c7 with SMTP id 71dfb90a1353d-5e91f339ea0mr2872685e0c.2.1791900923323;
        Tue, 13 Oct 2026 07:15:23 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde913d0sm3740707e87.26.2026.10.13.07.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:15:22 -0700 (PDT)
Message-ID: <720f7b8f-29bc-4b6a-85f1-34df7bd5cca1@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:15:19 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8650: Add watchdog node
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
 <20261002-topic-sm8650-deckard-watchdog-v1-2-7d7f7d71d88a@linaro.org>
 <f6febe84-c7c2-4aa8-bb02-5b56c63abc6c@oss.qualcomm.com>
 <8b331c92-ce18-4886-ba87-77b6156cc9a1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8b331c92-ce18-4886-ba87-77b6156cc9a1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NSBTYWx0ZWRfX9udVAxlXEHkW
 3bpPxOBk6AS97bK5j346bBZo0mlgvV3TcBXh5FiKbE1F9d61HkcK2VO48GcMMmmk57LDaA1L+26
 HBrjxs2dqh1swyRV3mV2fiX1HKCxlqMTPDV+eR2Helftn8HUbvFnHPewY/sSGl3HE06BuXnYY10
 xREsH3nzAjwV0aGTvlKDGBu0bXwvmUT6PIJzc2Feh0LUp0/jaGTfEqimp9a9G1W/uUx25CVkQcq
 iLpKMPs88Y8nwTqZP2ALhFQQfDX/N6RgHGw9hfSmEEb8aUufopNSpNrt24vvNl/xu2Z8O89d5A+
 Wlv/2FcR+zaN8lDFGjYGb7B51AKZGlTS0w9YuE2kG2762BrxZr+smQzTX3ZfdJdaw7Suh2ohxC6
 nAyl/z3HcEqP+4hRhagl/aL8XicqX6PUKXtR70Jo0A8N3dwkqXoy5Kpz4hNwNZ0JdDHPRM8nMfN
 keGX/cUbnp3TgGv75DQ==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace3cfc cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=A_RqQ9NLQzPOhAJlhEYA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: f3vQ9uEtH2_v2f5A92QxF-sGZzDeuzBa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NSBTYWx0ZWRfX3f7Lc8mvdbeT
 fhjG93fkdk0B0Xjawhe/jUmTrt0gNpyKOvJ/ZsvKYpcoF/na+++d1I2lW72Y/WqebUgagRvTo/6
 4OE96W+xaYJ3eWf8ihcbcBsMLGrqy/c=
X-Proofpoint-GUID: f3vQ9uEtH2_v2f5A92QxF-sGZzDeuzBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130055

On 10/13/26 4:09 PM, Neil Armstrong wrote:
> On 10/13/26 11:21, Konrad Dybcio wrote:
>> On 10/2/26 11:45 AM, Neil Armstrong wrote:
>>> Add a node for the watchdog on the SM8650 SoC, the node
>>> is marked as reserved since on most platforms the Watchdog
>>> is owned by the Gunyah Hypervisor.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>
>> Do you have a HDK or something with gunyah at hand? A couple months
>> ago qcom_scm_gunyah_wdt_init() was introduced to handle this -
>> could you enable the node and give it a shot if you have one?
> 
> Why enabling the node ? the qcom_scm_gunyah_wdt_init() will bail out
> if the node is enabled. Here we only want the node to be enabled when
> we are in EL1 without Gunyah.

Right, sorry, I misremembered and then misread

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
