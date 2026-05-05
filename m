Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0662392C32
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967683; cv=none; b=Ll+sgeXL+YmQogQiR3BZtMWR9M6gSOVpfvpbWNETVf66Mgx1ppNSJJDCdvFyrYscFKoeYAbUMpki76DGHwQ7+03eujWPl/+NXch/GaeKVzMTfbZeUiPwJqLkPWeC6z5M6sPUbyrOxKfldIwVbHLcwRLGEQfhZJ9/3u0stFkTpts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967683; c=relaxed/simple;
	bh=maTmERrmr4R6czOYH0VPfmBrwakiLoJPBPiqZv8tXOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVhBsfKMHlD+Jw27bGZ27PvUjVSxBAgDuR+5pOAtzsSuHFPOEyc2B7Hy9EyBMzK8pLAqyrS4b1SvD7VCe8o6xvHlENU4HDAWX2oYoAFYQfeCQZc/kusD/Tn4NKUuO3EpFUgfE4Y0IzZ0XK+GcnASh9wHszY1JYSAY3Wb9+OJ4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kI4zKppA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PYlTyktg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kI4zKppA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYlTyktg"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6454Y2bP1150992
	for <linux-watchdog@vger.kernel.org>; Tue, 5 May 2026 07:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5U19/uk4QSe5iuZ2ZZyp7AGl36KDAVuAP0BMdy3lyEk=; b=kI4zKppAKshgUTaE
	nHuuAYG+Wn4r8g/dWP1MGuuuOIt50LGit1mGonmoCF3/zXDyQYQgcvWqTf9MrKBN
	/GTQiLmPj+4enFp3CVxBpgllBIomuzdkvL1pgTkZtpf14kh19QDZW6/bU0lpsSwM
	IMASotFVncnNiUSF90EQHadf1ThForjHA47yZc6+yaMaiwg7lY/m/Eu7mG9b4l6X
	XDBJNSYO4+07vX97LQstreWOC5TQSwFyn3AYW9rMApL+63mzRhaFzO47qH1fYhcG
	tVWtyYGamh8RouuXPNkZD9XTEMzJN0+RtOayvsdFiTVeGm5UPORHIa/9ROBfoPNs
	AdxHEQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscyc0t1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 07:54:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d8e8c47a3so141272101cf.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777967681; x=1778572481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5U19/uk4QSe5iuZ2ZZyp7AGl36KDAVuAP0BMdy3lyEk=;
        b=PYlTyktg0unOcnBBjnj1zv1PPbdZWINccUEflf8JnSxMYTxXO7erAJDArRvYtK47w8
         OulnhTByFUjTT+39WiVcolosrCqTIXp8HeUZkA7cIdt8HnJttnc2QAlk0gcRU7+QTBJu
         ZXTb9A6Pi85k0EYer2Hu5u1ooeFY2gYL5hR6xEiAyh7T8hqlu9vPUmFLcarfC6HoqQtE
         3OO88gHeFTIVnmluYTKYk9G3gKNBsCyPDtDG81FO+Ly6uyLE4cQl4M/uSXatnzj/s04f
         4oUFxyJtmiqAH1mDicyOpqSrmOr4icgv3H0KuVh7qRGDEtQSB7yeZYgZ+J8IAQKM05EE
         jE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967681; x=1778572481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U19/uk4QSe5iuZ2ZZyp7AGl36KDAVuAP0BMdy3lyEk=;
        b=TVcBVp7+gul4qWpzXMo9iJ4tyanhViRTkuc8gvcvGERI1u9coUlzR/QHD3lMs/UdcZ
         oKFL947GyGShBDZHYT7qkjTFA2PDQ08mEcjB180zRjMSzbeBtLUcDjDkxGUKQktpOn8u
         Do6qcKjK60dcYRWy1PtWfsftXJp0DVleqjlb7LxfRq6tn+K71wPyqFVlmtc6YJOmUkrh
         3XL6B3xi5AIpuUnX6NDUcFgnQppgnHFXhpAJWRS1wDC6I0/Q9cczDN1TRjY+Obx0ny8y
         vIFS+3gPi995134NV2sDTgoOW6AY33rJbPkf7yreLN2jPma9Me6sP8CZ8vQbWeDhQOy+
         1hag==
X-Forwarded-Encrypted: i=1; AFNElJ/fB4b9QorvqfglyHuNxO7+9chc9AD5DDiETUDA4Yrl8s2U99LHtawcqy1CADKt2oS6UNtVth9WQclFgxhkUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BZoWQKBSUUEP0h2hZRVN1EVZNU627+GVxLbNDV3Xh/lOzTvX
	PfZqr1wZdWEX7l61UlGvRirX22udNlqSUfWqXQ0r8rK7e4u4CIuJ8R9PXCNt/Upfqy9mpIrqDO4
	MX4JmDP0nL75RUHyJ9nI/k3mRJTSLE6dpE6qezoV7yO/EmSAqnESdVmTOhC1wy5HDyBfYOA==
X-Gm-Gg: AeBDieuYR6Wp53gwQhk23R1NvffW/nxNa7HA199coIjflM3MU1RxnUZX18eiiebi345
	PmHYk6opyhUbhJNxD4wOuBLjlTm7UrbYSTvBMuOf+19KMBTGZxtyruIVC7OCXE19UnveBe5rFKt
	6DH2LsXsTEmej145cttWS6yc40z27+qatTJeKrM2yIcB3vEVO8JtMxxmN/ESELFU1bg85shRPHi
	fHO4Ru9Bdo6TL7jjJk7JV3FCG7UoDbbrpOVsSi/YPTzlbfKR/j78Gh24cy/NweIfzP8miAGZnel
	kKMTJWD2ZtbGpMLMKct+iJRvLHFLc4/+STow6/w7i/o92RePJ2/wiN+DvEAUMTjcYxgN1Xd2JkR
	StzC92hxIgQ7cgJFng/z4arbvTYXVap2S9Q3COUg2+wLZU3pUMpGfNKf4jA72o/BRvmfZ2MkKgs
	nScHL/7sYPDHDJ6frq
X-Received: by 2002:a05:622a:295:b0:50e:feee:76c3 with SMTP id d75a77b69052e-5104be22870mr189158321cf.18.1777967680753;
        Tue, 05 May 2026 00:54:40 -0700 (PDT)
X-Received: by 2002:a05:622a:295:b0:50e:feee:76c3 with SMTP id d75a77b69052e-5104be22870mr189158181cf.18.1777967680329;
        Tue, 05 May 2026 00:54:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d? ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm2733025f8f.31.2026.05.05.00.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:54:39 -0700 (PDT)
Message-ID: <c22b2fc2-c10e-4afd-ad9c-bc43df820655@oss.qualcomm.com>
Date: Tue, 5 May 2026 09:54:38 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: s32g_wdt: remove incorrect options in
 watchdog_info struct
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc: stable@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <20260505024409.60301-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260505024409.60301-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3MiBTYWx0ZWRfX9WpDApzeiAr2
 CCNOv5sad9WP2coBBvSd4VdmVc8zHqOqN1leSzI7peFRVGMXlnX0H1df3FVQjkGjDTIb5OSS9SX
 zthfRjCNySh0GvYBhxDxzN1EiYoMO5jbpRTSyJ1BHmvyd4mkqSaTKy6eFr3WWE4+yTA8k2Gh9g3
 uaBRpUJkiQ1OtpSdDd3+km9GFjwMhdqAbgBBDqhCkIEBMoUOmGjpeekYZMxe+oTYR/MzjGpGpNJ
 RAIWNpOkLMhffvql0ai1haUyl1M73v/XKlXdqy4jUWtsEDFqFYTtazCAhdoP29DoTuI/IJ0ArwK
 90eSXrw7Z7PcnCzi6jc7ySINIt+7w7UTJYCINV+M3YEU55knmjHc7M+nm2jxHKXP0OAiVEAMYTu
 rh8NIKXZFNCk0w9rDdi9yRSs/h9dwdAV28o1e3YSTJFN5+DkZ7ytym3UaqyG5JNXGRcgVXh0/TV
 OTUQoRiutnvWtj/fi2w==
X-Proofpoint-ORIG-GUID: 1KByok4lMhA8DKjNvazP1pivixcyBPrm
X-Proofpoint-GUID: 1KByok4lMhA8DKjNvazP1pivixcyBPrm
X-Authority-Analysis: v=2.4 cv=C47ZDwP+ c=1 sm=1 tr=0 ts=69f9a241 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sjASDcFfOvue4x0fWBMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050072

On 5/5/26 04:44, Ethan Nelson-Moore wrote:
> The s32g_wdt driver uses two incorrect constants in the options field
> of its watchdog_info struct. This bit mask should contain WDIOF_*
> constants, but the driver uses two WDIOC_* ioctl constants (in addition
> to correct WDIOF_* constants). This causes many incorrect bits to be
> set in the bit mask. The functionality indicated by these ioctl
> constants is supported by all drivers using the watchdog framework, so
> this patch simply removes them.
> 
> Fixes: bd3f54ec559b ("watchdog: Add the Watchdog Timer for the NXP S32 platform")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---


Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

