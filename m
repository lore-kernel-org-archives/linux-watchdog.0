Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7344683D
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934472; cv=none; b=ob15O0KHnrwwky0kMWnZTtxzTp4di/CNaPPxuHZDCDOmNEQgPlkzfNOxftX+9DCuyHab1f/zrGlTKXRPNSbAfOW+g1lJJftmbCp5nE39nJytqtvTUthK+jI9RSM4SB1A2iiFbPWbImFYv2xGCBT45yZvH8cyNK1doa5im9mCcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934472; c=relaxed/simple;
	bh=9NFwvwjdEu6EpliaWOFU74+LC/R7K/xtZBjcetkEVj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPWT+GlMUbb3+TLkj5HzrZ7VjzIRniy23BasH9keHy3nyG2xk8fF5KF88sJr23TTh8wl7p4nDTGivrZ4HgzwR3GdEIQwkt+qw2AUYh4AKJQ23nnBd5BPTOmsgc2eawf3svsQxC0iWWGih8AZKLUl+1MqVAu8HhD7hH3A2f7ARuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IdpC91Pi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WgSKzqnn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IdpC91Pi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WgSKzqnn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925j6g6437909
	for <linux-watchdog@vger.kernel.org>; Fri, 2 Oct 2026 09:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RDxr7B1Xhs8FyRPO5MY0yhhg
	tVLuT6+k7rHf1WY5blA=; b=IdpC91Pi+1XRPC/UQEnhaP9ZlLBx9/Yi68IbBpsg
	wXIKTgCGwAG21e8eM9FAKfQxRk70YM0znhUEjkyOXKREFh2iTqa6iCvn7cLankep
	SDjaOJVHI2i6DIvEL5723icvkJx3QEPrAs6Q/CVw9ABBZpUIOjuDeS8BeATgch70
	cKEFS1nHh2Db0AnjP9oqOAtTeX2xqaBCUBT2On5h2TgSJLyFM1zm/z0TEj6Cz0ik
	hRL15kLJGkuC+XixWOF+UWbyjo2TnxaRhxARBeUgrugo0tgZPewv7rS+oDeeSA53
	wTHTqxoMi+sgnWRRJO0RRVichFoGPyCuiguEVoLdjKyn7w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdckwn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 09:47:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93bfb2da664so1968104585a.1
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 02:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790934469; x=1791539269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RDxr7B1Xhs8FyRPO5MY0yhhgtVLuT6+k7rHf1WY5blA=;
        b=WgSKzqnnzkD+pnytanzTTXXE+HgZ8L6sNFx11p9Z+JiIQdAfiZ7IeOUOa1wJD9u/T6
         p9gzQO39M0OE+V/jiUMOv32LhhedU63sy7fLPEVFf6CAoafDSbhZVQ+70gYdkDU1i9En
         StY2nDXvv/8s8JjcNinRWJUK75zdWjCiAOQkftqzla05WQtindLI+iYJqdShgzcXDz1t
         PXFGkCWRMR3ILG6wiGcGG3zUc5OUt8FHaDp0icjZf7GarPG3PTGQquVRIGAvoNuZfpcL
         5iBcK1jml2enU98/rPyso9Olfgjc/aqkJSGi/YCaQCZ7iooeBVqfI0XPw0zdMcIth2lr
         /w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790934469; x=1791539269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDxr7B1Xhs8FyRPO5MY0yhhgtVLuT6+k7rHf1WY5blA=;
        b=pSTjAU3/FMY1eD1zVexIkX47OxjE9JCcHUr3m6Q3b/M8Ofm0bPKzn+Y5jrsLfiEge1
         emHKDSY25s+s/MMaRmeC5ZdiZr+Rie5Jll1KfcBFVAmomE586l8hdotaI+hEpDn3OKxi
         Vsri5t1YhCoykUbDRMHJH8Bo/O7l0DjqvQKLpWgvTknHP4zQ56ZMhHSboYI1TnTHlZoU
         s7tO1P5UvsjdSQja7OvKFfD8AT6z5QWEpUTvgLz66koZcI4h/NBYlZ8OeTXvvgAqJnsC
         kqy5q5urnuXjKZiW4VMn18gMVZdZ8OPniplQOxtzwpVFDrDxTFdaHAVg/VPDl8siUGFp
         OLYg==
X-Forwarded-Encrypted: i=1; AKwUvBz88dEgKp04+kaqZ3GuTK/mRJnmju6frocbAc7aZu1tqZb6MAzjRzQNq140joHVxcig6qO4ADYNRMS3pSPyMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mMEX/bNLohHWAvqcH5xW3hdnmGmOqIvucBhI/RLbWEb2qc7Ttc
	LEznqhr6FO7pq7GjH6XNcbwDJNvX1ulr4cvmDXPkDwi/aTC7b2WS+3JozknC1K0rrCbZp9347lh
	ivwMX3HrGQA3anv1nHAypqE4ok08KRcyVy6rgZwyJP6JcCv25DlNFwQB+rLcn/HPBc3v9BQ==
X-Gm-Gg: AYBFou2xb4ao8eMNQdgvrfjdbj5FA5KI9wJ3nuS4K5YSjQxwS1RfUnfqFNXwaDTnmrm
	X5hrXRzJ7QvP5nPtdIZYLZvMiHXqERHgB5uppXXgq3Opc7XZOPfH9udoCY/CiouRkJy/tCcLP9M
	BVlaDAhPN6aAT154IdMKNXoP4+1yvFOET2JJOUPn9TcPjM/edqCZFD6AHTNNcfWwILrfkNmQRRt
	SBMrOVQs4RKS0m1SmhZqO85ncTpX4j1rMTPNQNPzDGB3I1h0rzzi8Dnwp6Lc6TSnuy51Vysh6iB
	f2t8LBZbpXomYnaaullhTTWNqGivbrbnYA7TD6895SSKy+jU6uwJrtD+OoV6bjlSu6wY9s57P8I
	z0dA4V9bs6Y1o3Pc=
X-Received: by 2002:a05:620a:27ce:b0:93b:d7a1:ba11 with SMTP id af79cd13be357-93cf18bff37mr336082185a.60.1790934469359;
        Fri, 02 Oct 2026 02:47:49 -0700 (PDT)
X-Received: by 2002:a05:620a:27ce:b0:93b:d7a1:ba11 with SMTP id af79cd13be357-93cf18bff37mr336077485a.60.1790934468708;
        Fri, 02 Oct 2026 02:47:48 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104f89sm5011766f8f.30.2026.10.02.02.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:47:48 -0700 (PDT)
Date: Fri, 2 Oct 2026 12:47:46 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8650-valve-deckard: enable the
 watchdog
Message-ID: <d3s2tbf2w27kf257xxtw72ofpwtnl5wqxajzsgw2kbgc375iti@3hqht33dtekb>
References: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
 <20261002-topic-sm8650-deckard-watchdog-v1-3-7d7f7d71d88a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-topic-sm8650-deckard-watchdog-v1-3-7d7f7d71d88a@linaro.org>
X-Proofpoint-ORIG-GUID: aRJnH2uke_jTlDHxLRFnswc4c-vOEQSU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzOCBTYWx0ZWRfX5EQyqI8816cS
 asdz/YLIEgSoJL1l2qzvyOVe+PaEk67uFmqPPo40Yay0ZTz/EB5asYY19XsiJPGeyzb+eExh56m
 EjXZmip4AUzxN94rbLN16GYHONpGZGg=
X-Proofpoint-GUID: aRJnH2uke_jTlDHxLRFnswc4c-vOEQSU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzOCBTYWx0ZWRfX84z+XMUV02Bn
 pxnw620RStl8bKy5T8QzA58ePKXuBf5KYuXLjuLqc3m6yuDmo72DYFnpXnL9qsqRuwC43nmjZjm
 breNk/ZitYdjpHd+P8RG37R0l0lE498I+xV7qWmCRXiPiVAzqTpjRbxH6z3Os9BiGtqwRsFG1I/
 fku8kaig2mu2s9LGF1CgFa7bcMkzlCoAw3mB0UKsdeiqjW5aU05P3AR7Y+vuZ6s4h0cR8BHbU3j
 VbqhCah27ad94FBodk6d/UxM0fQRv3nwZgK4wE28BNZ8STw7zOjcWRN62O0rLv7Wg/ya7cQ2Yx8
 /y3XZxqjxvOLsgP9P4BssaWv/4eAiyir2jTDMUcb2jsrGt+xecPQz6JpzyvmPofiqmWRYe6hf32
 Dxd4DTrauB58R4/jvuXaNs4SyxKMmXv9+sv8/FITal4kIgiVuO/IqfBA4nu/TkAFpm5iVo7OwVZ
 5Es0FUA75c4UO08QvmQ==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abf7dc6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3WhsykZCFRSWcWe-wlIA:9 a=CjuIK1q_8ugA:10
 a=3Q3lADbaBCgA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020038

On 26-10-02 11:45:30, Neil Armstrong wrote:
> Since Linux is loaded in EL2 on the Deckard platform, the
> watchdog is usable by the operating system and can be enabled.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
