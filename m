Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C726ACC
	for <linux-watchdog@vger.kernel.org>; Fri,  1 May 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658766; cv=none; b=gmB/Nueyyyb/zJqF1idwil9fIYZrYOlk6hQlgmrrW3rNcyX/7Op3JoU912eOJV37nNn3ilCl+QybkJK9H4ynOMYMoF+5KgDzRsSLgqlHZDWB01drW6dnIOIXDznZscciN3tlsIWtyTHNEo9VOzZDGXR5296ngRBfrEtwo2C9t/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658766; c=relaxed/simple;
	bh=IqJpqOcqeGDRmUnMnSq7T6iNQMa6mErewLZJHnE83z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=baoTxfmIHHJL8QUKwAJpwy+GqYrCgaw1Ajy71iKvSktvWpLzoDDOddupd/FkIxI6xTLdhMWYLS7WAwUfm4SS6xLRKa0xTbTGo7wii2ySb00w1W5D/TUUmFW7xZ3poUFAsy/3GhoIgIW6PVJ7c/gy/t4yE3/pay5//19gwTIF1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Av2I9h1O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Es3E1sNi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Av2I9h1O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Es3E1sNi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641GLRwE1754411
	for <linux-watchdog@vger.kernel.org>; Fri, 1 May 2026 18:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ytfNsSNY3xQkbXYwbjLggA
	SDjxHz7IDUGwPrlDCTJD8=; b=Av2I9h1OtzvvWLH6mRrAGSLDvxjTTJ2N669AEA
	n1ZdsCZJD1G4A+UD17LvFuGjPrNyLRc/PtoKeSG9mI3emjRLgh1/FrhRBmYZc5ku
	p6LirQmqvZTm3RdPjktyBsLHnNXsOf6s47TYNJJ3eyx98a3dn1+Y53tgoDrAM/s6
	VLV9Wda7XMry7XoByL4PTwqEtYiuDhuAM+asObkZmzTZWE7VxFXK1QNPXb1k8BxE
	S6iKpUsfYx2QVjGKZ421h1ZuRqJg6b7dho4hBFFejG7vfljh317dNlW9e3owAaBQ
	L7yn0aAijxcOTdYruzvrQGvQj6iRqMOiOGZDydBHx92Pjs0Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvyde8e0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 01 May 2026 18:06:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so38899365ad.0
        for <linux-watchdog@vger.kernel.org>; Fri, 01 May 2026 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777658764; x=1778263564; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytfNsSNY3xQkbXYwbjLggASDjxHz7IDUGwPrlDCTJD8=;
        b=Es3E1sNiWFnf3udtePOTX6oDo/aeP7Ral++sqnf/xV1LNbo/fOGimyd+ttBrQs0MV6
         yRx5zM8hQLVsvpEkComL0y0NehLsD5vPK+CDnOxhRwyrn4cASnpQnN6bnCxQzWFv32B1
         NIOwVFIFgK+5Dyo/dqhtY8VZK0++YtMYBlQuZPU3qwTtCCBoCzmPPfnvfud+Ufy6GKOT
         ZkNgPAAaUcKxoKOPjIR/W4bWL874f1l+XJ+tvWRK3EotmKzzBrSb2femKqnTi95ples+
         qYIHNDd+DDGe6wnoHRI9ru9PTQjwDqo9JJgq3WPztbt5oCr91TvAQWCycNhurFKfQQBV
         A7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777658764; x=1778263564;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytfNsSNY3xQkbXYwbjLggASDjxHz7IDUGwPrlDCTJD8=;
        b=Fy1E3TlSXYBSk3vllMmT/5YcrlZqYxO0hKLDMtxmAUPzYLdrGi7gCf/PnzXCEmIwri
         5buNxX1+bBuJ7IrPw6lxBzVtcNidxLg8+gMrPy+lt1z6OrvAbUcVWEY8Qbs+6rfjksOV
         YR9jWQ7IPB4pV9modJ/szuM3wSqGgSsdpZSNWvqRXP+ecO1DcbWQMHVLCu00wGOzK0OG
         Lh7g8R3Lef58iqnVWQegN/G3gTxPaBQpMag86Myq+iNCZDq1chfNEOrdB32H7WsAEhOc
         8rBsh0Yqjw6x69mgPYKxvfmImNx1RnrC9Rrga8uI3QzP3u3B1pWLAoqyhgjG8D4o+aTl
         bBHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/F+ZeFyyzns0RvagSLA0ioBTxsn034Q/shc82V+yUBeIMODSJbJ/5m01a2ZsiCkgetKjzTMC9ZftKa08Wyxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCCiUblC/6S3BbpL5njRH+9TqsxJgJJusQhutcAjeqsmr+5YTu
	lljBu0vCt4pqnvKU8P/ZSTCQl2P2yN+3E+aVG4E/I0+/phvh8rigWCRcczBOnp+rr3P2NerRmgG
	YiYplXwnH9yl9fYROBt1KZwth2P1ZSSKAzUspGTQFY8V4ZWUNJcUXtN2dy7bT7Nu+MK9giA==
X-Gm-Gg: AeBDieuWNi5vnvKal+oqJcTCtDkljJu/YkOyr8jS9QnDCTQ2Z90L8sRA74iHK73yX8O
	4kF/wqUG7O49ZNrAF9C/uqJC20DVTQcbCs0I+5sf1rGhLH+MAMen8iPstLTswmWDEpU6t1nNDQh
	UQ6jOwFYtZG5MUSfyBs0tyCLTyXI0xJ+k+4j/doUiLy1lt/eKfarDauqUntKo++6Y1M/9zbET3l
	/idgTViv9bd/wvbNQguqpOMFDeW7qd2nmZkfp/6uEBz8Vsqlrg9hviYsdPnEwtZRie6UTmGFbTU
	nQIscGHThxWgdpUv6yj/0uDiZpolCZ4s8g+nW4S4UEJrcUJV9vfilipQWivjYD85sROCoTehTvY
	78muw4d6C0MQX0Y2e2oRxO8IcLsnNnWcB89PsUquJhlFaE9U=
X-Received: by 2002:a17:903:178b:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2b9f253256cmr2500405ad.4.1777658763931;
        Fri, 01 May 2026 11:06:03 -0700 (PDT)
X-Received: by 2002:a17:903:178b:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2b9f253256cmr2500135ad.4.1777658763408;
        Fri, 01 May 2026 11:06:03 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae4fd16sm34804905ad.69.2026.05.01.11.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:06:03 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 01 May 2026 23:35:49 +0530
Subject: [PATCH] dt-bindings: watchdog: qcom-wdt: Document Shikra watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-shikra-wdog-binding-v1-1-fd8c14bc2d20@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHzr9GkC/x3MQQqAIBBA0avErBvQpJKuEi0sRxsCDYUKwrsnL
 d/i/xcyJaYMU/NCooszx1Ah2wa23QRPyLYaOtENohcS885HMnjb6HHlYDl4VEqPym7OaOmglmc
 ix89/nZdSPrJVO3RlAAAA
X-Change-ID: 20260501-shikra-wdog-binding-33873dcfa81f
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777658759; l=1019;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=IqJpqOcqeGDRmUnMnSq7T6iNQMa6mErewLZJHnE83z0=;
 b=rx06YHRgOOLbElY15UCGfPTvLsZqgFYqCVfvPklf2GXdyQx84vl39FVw4v5tygvaZv/aaoi/o
 vdK1l7JiaQUDT1+FzgZyXANUs6rrCL7weSRT23Pz6T58OirSoFC7iIE
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: cEfcYIHy-JttqErzqsM8PzFi-KrWZ1Rf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE3OCBTYWx0ZWRfX8uRUFNjxdgrq
 zyE3rbd2HY0aMfr0kT5FDzC2J6YpQchgvLZT+8qJhKQz6T8rGSDoTLV6rY6bjedr217Z+vVOIxv
 b8shvYreTwObqad9bEbL9cFH3ykYgpEVDhJq+Nlz/e9wHfSBSdJYBQ3HaeSGvFFnb8AWCUGzosY
 1WRaD14YF8vhL/nET8V/j/5yFfewW0mKHQB9SGvMza3tHebU7Zti7UAL9chnqkChCtlvdKGPfKD
 K8IU0Sd4vh+r2cyUbBbBW/6IPfHH16uji7sCWeYvTXJ4o6wN/dL8HWsSs2VZfz7+SiXCOyqT1vM
 ZvQTsRurImsq8gz/rJ8dKXUbeckGPU9gjAull3wX49Pypa+Yi9BCUF8cmlJ66fl7AEnalzEA/bB
 Ju/Lb0jyxijpTHAWqGAIkeNoP6pFJBPfynz5gIUJASCooH9U1xYmbrRM0M+Go0NAAzelrLcVgpd
 /rlCuOa0W6CzjI1zSyQ==
X-Authority-Analysis: v=2.4 cv=Iaa3n2qa c=1 sm=1 tr=0 ts=69f4eb8c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=DX6wD1BsUSLyRYCk61sA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: cEfcYIHy-JttqErzqsM8PzFi-KrWZ1Rf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010178

Add devicetree binding for watchdog present on Qualcomm's Shikra SoC

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 9f861045b71e..69ab3bf5db90 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -40,6 +40,7 @@ properties:
               - qcom,apss-wdt-sdm845
               - qcom,apss-wdt-sdx55
               - qcom,apss-wdt-sdx65
+              - qcom,apss-wdt-shikra
               - qcom,apss-wdt-sm6115
               - qcom,apss-wdt-sm6350
               - qcom,apss-wdt-sm8150

---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260501-shikra-wdog-binding-33873dcfa81f

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

