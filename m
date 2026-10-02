Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4794746AE
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934339; cv=none; b=EBiBZb5c6lMsITt7hp632ato64sCKT8lxeDxC3It+BBQOfHxwjD46+O6RgL/jD5CZhCg7D/GTFteYHwsu9YyCo4enqoL0mLVRMUr5PQCy6VS4eqAPX6f1KZfOevZtgcOI8tez1u5gZSE21jIET6KaM5jaKjcNx4mqCqwaw/rkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934339; c=relaxed/simple;
	bh=k0vf9IJe5mr2xZ4za2J/iwlEqUm4UT3e4X4gEPnokc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qocgsz9vZd30pw5vSr9HtzYPuo9AJ4w3jhlav/u4XO2AOPANRoJyxDREPVU5G5Y3hThBMCBnIC8pviF4YYr8jt5MlCDFkCqV+mBJqf4KBd5d2kt1N7yyamgBOOJQxQrJNkotep78inVTstagDfcboKCpg+Vln9gwlEQ9ARkXFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TCFjZQmv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCFjZQmv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso47194595e9.0
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790934335; x=1791539135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Whs608MpQHn0fcanZf9ChaNVLNdoG4FAnM1K+j26AR8=;
        b=TCFjZQmvRCZ0Ac3ECygeznRIGOnnIp7bn2P/4uVqZEKe9K+atDHW9uRtG+oKvEed78
         jzVsiyObjXzmZpBox2DvTqEEvphnqOGm7fdo2BWWwbIzTToAeHV3Xk2LbR+XGXj6nrrl
         uUs/jY/UmENn7JVFZi3bIZm18V0iiKcFWZh8XVFwi0Nt+trAhY7yPD71QoFwu7fw2HPj
         f5/GAq6A9s2Ji43qQLVFGcxCkTITfm4SI5gVzQD4w8RsdtTkQIpKM6PgRj2v33/ZKitZ
         frgUD1MVoHxQNyPshcc0ou/jVebRJiLWf9PL5nwaH2rJydQ+fqACKJ+JzJatHRTjGiHT
         HTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790934335; x=1791539135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Whs608MpQHn0fcanZf9ChaNVLNdoG4FAnM1K+j26AR8=;
        b=cK2j9jJYz/yhxXgKILyRxfs0wWn4xMfyuh09horl0M1m9IBci+Sn8Xy+8OdS2be4Ub
         17YZdepixX+Zt/RFah+2FgKCl9VlglqBzQm2OYxeM4Ynzt9Or8uWMUtoJ6as5PIa14i+
         /M4FpxtLDydT2wIlHI0my2rNnybAz2z7kmMPS/jInqyxRlFwZkIlwTZv/rrQCNwUA4XJ
         UOZ8HKhA2SM69kJGxHkblgXboq+0kyYuiRtdijvnNsH8by1fFcjPciLBVt2cGFwXwugL
         N+b1qQxGzOsO646SmaSoDqMlv6rYMNrJRuLgQHLZ4l86IkOm3D5q5crTwi4hUwn4qwB3
         RGVw==
X-Forwarded-Encrypted: i=1; AKwUvByItzC/hz8M6RzIjopr47q73+5I38rFs0b9a6KbwnKk1y0PylsxIP/ULHYXAnMhtWl4Qkh9tOE9vkQsmBCOcA==@vger.kernel.org
X-Gm-Message-State: AFuF++nFaWLzVCKuXTXwQwTZ+yDA78a/Ozfxw9TPM70uaIZBJyjO7bRm
	YjfukX5I5wy4W6xx3wWmKa6lbudKu59BflzORb+d3pKI52LdE8G0v/RsFMqbkWFqGwQ=
X-Gm-Gg: AYBFou3cs0P3oIiEBRjt7Gyw0AgoBKZtA3z9YaDyrVaZLWCNG15wCaIjOGm6FepDje3
	S9y0yqayI7y8oJpWpx77/DDkaI5cfgCiRcsMvStmKY5c4gr+3sR/ShlZIi+aN9LJeRgWbE5via5
	L6bU/vlp++/RsVC2I+ibAoL/0J10xJf/HiGqGc8sjZmrkU2L13nctFQyZsWoGPekigZHJQULzas
	6Wt1Tq3nRI/B3f8/wN7gksJ763OsShXrK2+x/tmtNimTg/CTvSPj1fOpdHC/JVulwbSowXEkGEx
	KP7KLCTsh32tY1s92DPGUxC4PUS0lGlFU12k5R1XhEJEVeIzb7uZYf8FOx2ZAw8m1y0DA1w8Bq3
	XyagTSde+Ycj1PJhOlyIo3wrP8lQXi02Te3GUyucn74i1PhIYeRQOaEqK2efTnFMigmZATLxmcB
	i508+12TQ/MC7iF/ezFsx5ceB44t4hxA9lBklE4g4w4MJTXEBhxrLq5y99e8YGXYB1x43fqSGo7
	P1zuSJg1B6fiyIax0Y=
X-Received: by 2002:a05:600c:a10b:b0:4a0:1c94:7042 with SMTP id 5b1f17b1804b1-4a027542267mr31818345e9.8.1790934335444;
        Fri, 02 Oct 2026 02:45:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c8bb0sm72705635e9.11.2026.10.02.02.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:45:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 02 Oct 2026 11:45:28 +0200
Subject: [PATCH 1/3] dt-bindings: watchdog: qcom-wdt: Document SM8650
 watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-topic-sm8650-deckard-watchdog-v1-1-7d7f7d71d88a@linaro.org>
References: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
In-Reply-To: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=838;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=k0vf9IJe5mr2xZ4za2J/iwlEqUm4UT3e4X4gEPnokc4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqv307o/zudbjHuKF52tsKRiGR41jSsZ9EofxSYEwF
 u/xRq/SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCar99OwAKCRB33NvayMhJ0RGTEA
 CSXVLhNJEeYoozS8xgfYmrDj3hHsVBLpx4GKI5vRjOQ9brQbqDsuGZFB0I5ZmzGnSTD2igOgP/UYAL
 WWfZbaHz1ZEqsJtAwkybzyZ5FVU6+KHdMjigaScGB7Pn4PwGsfe8ZVIiHO1OA/1CutAxdwxkz7C0z2
 QMt/zlnNVSHzb6H9Okg0BPOAaPM5ZjwzBkliVk2E/n2WB/VNVNkuY/0Pw0k3YbiACwiRfjayKy+9Ug
 OkeYhdi/OkLSsTx0kItUuMbB6v0yH1vwKBeS/Fol4kd9I0cq8EOX4ezKuIBT8H2v5rKyJbgvrisD2G
 Y7sFhEXb2f37kfoQZEIDqYi4sK3LtDPdeAg6Qx04lTPnEuUnPAXYNrhuLoMUX/OwggRo8WxTDbu89W
 MmAC2WGh2M1eG8cTTS6VImknxL0+AcgiTaBJRpj+WDMUpMmH7pF2yY3Twqjc90jVgKExJfPdBAYx1m
 Fk8P4DVcy7i1ZMehyFwZ7++3ajmuOGuZLSxI4TGranCJDCDLyJ1zp6PhAzmlZSBSlXUNVss0h4u03l
 B9hBdn9rvRzMFHqSVlozPelFM9dQgXbNitIKBhLrrOH/novqCMWWOCVy/rG+0Ktk2nB+tuPAGQ5g8b
 srnX3VvChZH02a+1glJ+98c3rmKIUywD2R2SnCbv4fo3WwEZV931zBs+m5LA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the SM8650 compatible string to Qualcomm watchdog binding.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 4ff61102e407..31f9dd24c29f 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -50,6 +50,7 @@ properties:
               - qcom,apss-wdt-sm6350
               - qcom,apss-wdt-sm8150
               - qcom,apss-wdt-sm8250
+              - qcom,apss-wdt-sm8650
               - qcom,apss-wdt-x1e80100
           - const: qcom,kpss-wdt
       - const: qcom,kpss-wdt

-- 
2.34.1

