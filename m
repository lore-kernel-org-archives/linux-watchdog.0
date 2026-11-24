Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483725;
	b=X49L1u5nrNE6EBOc4eFe6+jyQSVcWUDUPigLduqgvKSfYkxMMtCkWlsj+RH30A9W5uJh
	 D61DJ2AJgL8e9Vj2HVIdf17V6f4gEuiIzvDFuxwphaSOoeC5BmBjBC2WW3t/BPMbgj7i+
	 jYJo8MtvB6a8OVz3TQLvB/JwP3BH6K5toKu92y/Hj/fFNDQTC/FcgzeU87yK/zTM9KfXw
	 44CPZIzCUYID6dfO9o2kjWjwc8USkD6PuVvEtwj7HJvK4frzsEBI+UiFTLj3fL8bLQUkH
	 5KVhZN9nUoprvbonvCx+z/UMVxuT2nJqCcUVLjjx22eJfwmKLLu2AS8hwUwcJiHowew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1w/HFhKVIFry3YZ4gWPmqGE+Lmzlg0zffNXSei6jGjE=;
	b=SOzPC1S6Iw8XBY02HtpAVxpHYjqRwpE0EwWmX7Qt6u21EFAiI1EeP0NeFjJj6mmNGcXc
	 2GrDh4Oj5aktDlT0ydi6eAlkQAcTykqnIi4urEe4tFlV764g7JHIzCM8A0xT0vY/WWfo4
	 CeIiZ02yFQKghXa+21kIifpnafRBWRpCJZDDaMCnBwhLV+LsYug2g8+f+NdCMGklUd2r7
	 6xAUsOiGt5RXqMbhVsBBfHZJIbyiEYtJLzC0h9YohPF5rzNJd7EuHYM1gQbOOqQS0IwSF
	 QQdSJxZE+3sN19THwKVyeLRzNb/G/lvTwXOT5xY40uOSPLojODtkhxEaSKFn7bkRC5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrJvk7Rx;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEB606A338
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 01:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BEB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrJvk7Rx
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1836746b3a.0
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 17:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483724; x=1796088524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1w/HFhKVIFry3YZ4gWPmqGE+Lmzlg0zffNXSei6jGjE=;
        b=rrJvk7RxSF+ASR6tC8nWJBnBvhZfEJMSOXXR+y5F1FvM5tXWP/ekOnFoVnIfwGXBkk
         CFqYLdA2FE/GvQ/4EF8JRIL5Dcop1MZobT+LNel+6lenlpD+b+me47oV/wGniWiv8qZo
         zB77q7Sopxzl/WMNtXNLCdvsceSHQyWbaYaNaSjc1/oUKbZMq88nbvSu3fUCrINEpqTI
         lAWqx2+b0qcHUMwtq38ppeXo99QuUcjYBVM23P+DMk2Ga/XnzjmdtxFQmPllZ03zrWrj
         ZA9yzE/gddItziRoPhv7NIwsSbaySsz4BF53NlSxizAdYmLgP1vZWD1SKIcanGSf3sg9
         nGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483724; x=1796088524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1w/HFhKVIFry3YZ4gWPmqGE+Lmzlg0zffNXSei6jGjE=;
        b=Nc4fdQ+gjLbkGgOULsIahycyt/23nR5vuhOtlr29i8oU5sIyEjMvHQG26Lkjx1qekM
         utboy0w8NqB9mAyZOC/Il0YuPQgP5EXG9DcKhYUrnAm0NgEAo7blM9e+bJAOZCNMX8WO
         TkLxLYbe1k2NrIWU2doV6mjKYqpz/BNlhPQkpmmkjBFFDqoS/te3fTa39v0hPP6+ayUF
         9RSSzjKChK0DzuQbATwM6fTaMft5FSU1VneRDs1HoHPR6fMYI7xVqS3PvYvYjrnyTM9c
         ghcIiO0seIkPYSgJkxsNWzJt2q/oMsLVU8V0cpH60dywghadz7dSYhdXAuWVHWwiOqY0
         kxfA==
X-Gm-Message-State: APuU4Z9w/EhKwBokA1Ere4xPc1ppItsQCqouVTLztsGoQkUPCaaAqdPF
	UicPY0Yi7vBq8eo6c74kls+/sPxrht/f8lLVgz6uXFpNnGIGTGHAK2zhtOpDpWXA
X-Gm-Gg: AZFdTZftwhV09norfrrj/mZZDrnLvjIReOd6t+zHim5tOQFeTYJeQh4WLhNXliedPya
	RlyslJzst2uS9RWrzMhvHEKyTo6xvTBA+IM+KFI21oD3dJDUCKe28dOFWUcsqNAqA7dbn6g5oBp
	S79HyEswOLeiNW++igylz5VemYY3gAJ8WnElmyeo+Umw4rhrForVHf3l4tuo8QefGhHEPay6c/i
	1S7oCNJN7fgTxBYtrsAnpCrqzvPL9/gwmLswhAJLmAZTwbYfSuGqybG0Xn1px/P/oouFpDnTlnp
	cWJa0dAHbFpEqs3whMUL2e0pR/eZlnIZINilBJ84QI3xxXqSwfA4nJekPy0CpYWvIruigsCPYxD
	weBvYAnuDQICHOv4TGCvVSf/iBqmhFOJNzSjh+eSSl1RcYHWmlJ/FxbcZUk8m/IugYaneuwxJUw
	lCBLOoZxkuaxTKAd8L0B2HbhBaPcM8yEi53dB1b4hqy57exSAzQk2XUwk6XtRVv8pYKqt4DZP0P
	gYcUTp4sOJV9+U0W1DZD7leEWRcN5VEAgrBbVxilVm6ClsBi5JAa/hk0rkNPprFluhFo+prcUf1
	spxC3hzaiM2k7+YkNUXJiOrMB0yCB8MCUlMIR0HlQRXDUzw9/xITSP4=
X-Received: by 2002:a05:6a00:17a8:b0:8a0:76ea:36a2 with SMTP id d2e1a72fcca58-8c87d3223f6mr10929581b3a.54.1795483724096;
        Mon, 23 Nov 2026 17:28:44 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4d0:8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e457d1sm6115243b3a.30.2026.11.23.17.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:28:43 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] MAINTAINERS: Add HiSilicon STB drivers entry
Date: Tue, 24 Nov 2026 09:27:38 +0800
Message-ID: <20261124012755.328774-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124012755.328774-1-mmyangfl@gmail.com>
References: <20261124012755.328774-1-mmyangfl@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the HiSilicon STB platform drivers, covering
the histb-wdt watchdog driver and the existing histb-rng hardware RNG
driver.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ac5128b756e..117823c25f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12187,6 +12187,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 F:	drivers/mfd/hi6421-spmi-pmic.c
 
+HISILICON STB DRIVERS
+M:	David Yang <mmyangfl@gmail.com>
+S:	Maintained
+W:	https://github.com/histb-mainline
+F:	Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml
+F:	drivers/char/hw_random/histb-rng.c
+F:	drivers/watchdog/histb_wdt.c
+
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
 M:	Weili Qian <qianweili@huawei.com>
 S:	Maintained
-- 
2.53.0

