Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8932F4A05
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769682; cv=none; b=uxKmRNFHJfDzBDXGs69hpa6iCeqPuBXI5crh/cefqUxze8W37Z23R3AL+2f2OWwVtlYx0UMOV+CVsoebj248PBzT0okqdRiQT43socnwReQCMxWProa8FtBr//T+bn99LZf/WRr6TELLzJiWjSbgWre3suCCV0yPriVktlbXffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769682; c=relaxed/simple;
	bh=GGmvXNw6P5Vlz93zn1jQ+ofKASXpmhMvNZCQ4FY+P9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irK2CjIe12PuJZlsqIMQGTa23Z68d3NP/cJP+3VZOJZhAnc5XwSZCZ5ohQDfSklYqiVu4UJ2EMk5+mUTAeIPKNHOvieOuBdq4E4c9bWWAwx6lrPwMNIvIPFLTnjuS13LAdJtkE7RkYwT2vIKVbuE+xbROWLEFTORJJBQ400kTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uc9I/T1t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TefvtZvP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uc9I/T1t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TefvtZvP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB7b60319206
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 12:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l7JPuT9XGq59XZP4IbyCjIJ/+oIPYdDeXhA4oj1suAY=; b=Uc9I/T1ttwViemg+
	GM48PNLwkmNDpdIAzf9oOvxkziWSdhyISIeGinhvzE0gADf5G9ZA3ErAqJlVrEps
	smedO6i5YWyRhfxx5junwUALaNmNK3963RcH/CTVZHGqj9vN1syWkEz+WI+0OoUh
	WD9MT3CcpxObwAhCmsa+ItwfwC9mJT9fJTCMCC4EUH28DwRKJnbN7yCc+kBoRUqq
	o5s/ky6F8JWDMFVjlpMtCWxwAIxsvm4lFHee2NS2bNjaUBHotLZDNlbWp9Yp2FKo
	mj6GZGwLIr+tcJBbVKblLn8xVG9AM2Q6dOtiycgNstdnLCQw+LmBmEYZhQwMmJ/O
	othQdg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfabhdy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 12:01:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5cc87885c6eso93755e0c.2
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790769679; x=1791374479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7JPuT9XGq59XZP4IbyCjIJ/+oIPYdDeXhA4oj1suAY=;
        b=TefvtZvPkK/uEzZpfRDy+HYmOMFfclE3MQsp/MZLOsGSSrb234AcwBuCNc7D183LMB
         y0lVx3UOMbYFvEqsHjo0lVgCl29bNJ17Bxts/GVl+e0D/yAeMQJR6yFFH9wDqZyhhZww
         rcgiOWX0gwmnZ457dlpM/tuU9+wldhUraxwfryaNdQ1Vi3IZWJYHOh1MURdqJkmuN7An
         446Cv+qZxhRefapItk8jQGUE7bGNxg5K8S5WgyYut5eU8sYh7l9fENhGAKeSFlK/ytp1
         h8Tl2W+xjmUjRd6/vxruyWUfSxwaOY82RLX6FK1LTKsyhE0M/r1P6bujoBMlmLLi5r9z
         NuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769679; x=1791374479;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7JPuT9XGq59XZP4IbyCjIJ/+oIPYdDeXhA4oj1suAY=;
        b=i99tbgqdGYtyvOMpKWDQp/qQnV03sXiuumL8ARHf5VhdJOAw2NsfxxWoQw1OoeG94N
         tgLwxSTkd3WI3JI8MCUXzvfjijZAD8QKiEiYdeJkJM9dOZI8PBv/NmDq6VSPZAu6QhFH
         RkOAHc1v2hDTYkaATiSLwj+dumHIkUbLOcaCbquBasDD7PA0FBIkOnlI99BLtWJcQ4Bi
         2b+N6oXWJ6EHWYDoImqZVIzdaxR4qlIITgz7LPneYyCJAjfwWI8RAF3IleoUvsl31b4c
         DadpAW85OWYjCLq136vvc5TESSE8k6yMiFSEiAFhi295GRxjMb5ERx9TZVXqDQoE1A+w
         qvJg==
X-Forwarded-Encrypted: i=1; AKwUvBy/+R4VWkdsn7G2ASmVVuMyynKnEn2YLtuzKSm0XPQ/XOKaADVquidrbERmbf0GCBSUMF9q2XVNeaDc5itEjA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIfSn2cUbeHkV/LSj7bZEGIza/fsxbDoBaJFS1HFnaIimCNVXSn
	5esE0WVtVLP54U72NiwwF/fcByC7MIEtf5M/Z1QeyEiP6Rj+wULdAGn6ArRVIXovcD1VvEyqW7e
	K1yNsyCRZmJz2FuUHDztw0BDGF7omhLadkkBhFu2GVrQA0eTDO2wNa44NO8c1UV5i6WASlOmz7G
	KDdA==
X-Gm-Gg: AYBFou031gw2b7Ae8rInGwtS+s25muOyBLl0i+mJ3Vtnx2wH7abdfoI/R82hpvV+XFq
	NHjqHCEhBt5opmj3eAstC2iEFRW6HDRR77v8FW9AWclSqEY/JZAoDxtBb8crZQqf+sZWO0wKXVI
	qzv8hieOgCEy7vzc6TXBSWvzxGSlWsVMucyHJ7+oolF+gXnN5UZUgRHFZfPlp7uRC9osd3+HTij
	9TA/+JFPu0vSmMpGtszS6OaBtPodTbgPVhNQsxDDFhrNoYXI39yadmjCcBhaTnFYhQpFmTrgiGP
	JUVJKvKznON3o0/gEXxBE7m7fS/3AXiQfy0CXwA2yb+dgsrFHJuNnASSf6DawNOz3nhl9snp+79
	6geHSBhDb0+mn9xXNvlFvXw==
X-Received: by 2002:ac5:c00c:0:20b0:5d4:41cb:8936 with SMTP id 71dfb90a1353d-5d67c6d5db3mr137630e0c.4.1790769678638;
        Wed, 30 Sep 2026 05:01:18 -0700 (PDT)
X-Received: by 2002:ac5:c00c:0:20b0:5d4:41cb:8936 with SMTP id 71dfb90a1353d-5d67c6d5db3mr137614e0c.4.1790769678156;
        Wed, 30 Sep 2026 05:01:18 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f4368asm53713566b.16.2026.09.30.05.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 05:01:17 -0700 (PDT)
Message-ID: <39902ca0-a7a4-480f-8e4e-40713b111637@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 14:01:14 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Add watchdog node
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
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
References: <20260929-sm8750-watchdog-v1-0-ea06d5dc7e54@oss.qualcomm.com>
 <20260929-sm8750-watchdog-v1-2-ea06d5dc7e54@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260929-sm8750-watchdog-v1-2-ea06d5dc7e54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0NyBTYWx0ZWRfX5J9Nmz5tOE2/
 J2p7dDyRYjTVEu+6BTkiC/U3dsAL0dj196iIbAUMUoLeWV+ZvPY1lVTA0U5+Bai61n+p8zbYDJ8
 1CaPVx4rU0DqmM5IpEudopPnYN9jCu6EaTzljtj+sghtf/it/0oR7XxOK1k6QkasoJqUwE1SqVq
 MIaV4fT3eXtRrH9yTxGDwSUN93eiphOhzFd6vs/15XoS5rSfWzWLzFtCuOpqpkKr9B7qs8S8Qg9
 +qPK3/Jo+eGHmC2a4YVCmnycxoF9AgdvxiBQDdUQ5D4u48Rh46mPJwxOk6nfg25HSyjxF318/LM
 w9cCUCMz8zGMbucZN50v3agy5Q97E9k86SDgorw1S4uBY95MLkMkUwx58Ew6LNprUCwuXe4QA25
 ezs7bJ1FlR+gz+eGkFuAl4752yjbhIOuUd43JokBD2yOaruSbZM4FVzqXn1sWBA2LNp7k3EZGYH
 4ayPL6z5nC2ZJA3E4PQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0NyBTYWx0ZWRfX+i11pijIm/Ig
 XV7nDo4z2SmD4lfVICxGlqQLxN7Ie7bpbt1kyR3N4FvVjPEOPYnmFW/yDAzIz2GTPMqC7l1wKnw
 S9dbOGLg03J6RyuvhTi9qUQkHqNVE3o=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abcfa0f cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=NVK-j4C6oOT1ijtQxEUA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: noXZvLZQbeMfUlC1FBtO2m1CZ-PEWACk
X-Proofpoint-ORIG-GUID: noXZvLZQbeMfUlC1FBtO2m1CZ-PEWACk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300047

On 9/29/26 12:31 PM, Komal Bajaj wrote:
> Add a node for the watchdog on the SM8750 SoC.
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
