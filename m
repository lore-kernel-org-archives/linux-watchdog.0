Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00A3E9C1C
	for <linux-watchdog@vger.kernel.org>; Sat, 26 Sep 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790421253; cv=none; b=ZwAsq6AB5xXc5Efw9d73V+Jn6FixbJgCzYQQWW6JAqMXkxsfdKF9PEmfMCtXUE6gv5MqkUZTCm8e4dhvrQKdEFT+IeysWOfKHqdb1X3Dzol9xo5kWpwAk93wtN1MeelaMDPNwh5zB9NkXZGTZpREpS2vIE6OAvjALnNahR0szSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790421253; c=relaxed/simple;
	bh=uPv4UccyYGYp+w04C3ZFpYtLkpdFjjqd9/HVJyKUkm4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dpcfwWsXWflqBczxqs3olrB4aQ/C091BQ/oywxeePuxVjMV1dkmpB0zwbJibSjnf1dZK5w+o/rMqx8PemxMMBQ1v1FzquUhop81AUwvF7jI+U1Z6U8MAeW5hXxOpJ5kYQwB45YmoTPpTs9xibotCVFM/DGj8NeOp46tEp5DDfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QezUhmK0; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QezUhmK0"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d90ba1d807so13363865ad.3
        for <linux-watchdog@vger.kernel.org>; Sat, 26 Sep 2026 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790421252; x=1791026052; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=99nH7QFts5v2NXRQt1KjX/jXCkzUNSZrFGih2W857gE=;
        b=QezUhmK0fzBUsEMn3Jv9qb53l0hf2p/4abU3leGtJ0qizYWTuOt2xPLeRPDXbI4prb
         JCsq81bdX2NtVIp4XNPTMPyNpB6pe+b3+q283I4W7zoKtUXp4zruo+0BmslPszEmhUsM
         ULZIiDyWPtggND4+19EbS4mOyolAaTIhn1AGzqcTZz/vUqgQuDTpUUGAuiJ2jXh5uHHw
         FCb+H3Ak09TL6wt90pq49Tkf/7Lp+vP72wKHI1inc+J56VO9RuLWJ0dZLQWIdD1bNtOI
         QAzXpJcpS6yRm4QrW+NrKREO+xhjBjqTZv29I2NtShvlLH2Qma2XTkerwJH1q/zfW6Fl
         8GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790421252; x=1791026052;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=99nH7QFts5v2NXRQt1KjX/jXCkzUNSZrFGih2W857gE=;
        b=cZSiZPd+EnZckp4HkPi95jV6qD6cbb7Fs4Svtt0J0URl4TUiEkAVAuOdhVP+0wXxdj
         p65cDs4eZJfwCmeJOQQx5+g3VD3th4PruaMvn3YLofD8KL4SAVYCSxHfsqvqWjy0DVFP
         1fEncX1w/cI3W7J5+AlFBLxMHFDfpH+N+S9vvCLq//sMnC+ULkaMQ2NNFve0yndPwRMV
         2f7H8ZJoD0Ic/0+kGvyhx7obqKQT8aCLNnrujaq3iYqIjVXAkDL0QuBb0KV2YuH7ATKE
         7f3bzd1Gg3EtehofHF7nZqSA826lT0pqAQl4yj545Kl3iFbTYf4rUJx3VLdKUxXuhdwn
         BIdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwp2fErCLUCEqLDFDWbyO3AoEVRv7wCFNdIj8BacweYlvtqlHUksm1/cX1rmjQGdaXXVughy2cufLEETdtLCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKgywKbnDsABjaIVjR14+vvEuKTZdysDVj6CgJOh5P/C61xXlXc
	JR9l4BFH2FxpHnhUT8oud7AVM0shPtmY7opL2uxLRQsnob8Z0lWYz5Xw
X-Gm-Gg: AYBFou2x1tMXuv77aTrVzG1OH65cvRRo4DUIzgsOWG5uiQ+ityslUvJy0biJ7yVQj+Z
	Syc++uxB6w0rYwyvioIDYgjbMaFo7WRfGh1DOiugsqWlRoaz6LW/VQzVv0wbCnDSqhVrvatuHjb
	lqwnbTteZkpXmdhaI1E1P/mNqDp2NM88qlZzd6muf4PJ5HQb6Ai+l60i33KQTgKtcgs7zhKK5tx
	9du7DMiLLrTH3QrWDfaAeJYiTxm+oNVweO3Lg5De2FFN7qoSJkm7mSEecIEUSsqIyBzka7kEV0q
	oWIh6a3ynYJTkQM9pk1DF2DUodOJ6sD2lQqOZdFD70GVNi5YT2gpfCpbNyoYRLHHKdddaziCDst
	GYr+5F0CVlybG5M2UNLuqk5TJme/xKbviQkqia6HfqU8n4DYGsEgjHbnKEUyqd04hydy95GCnUh
	iW8VL8rZ7v5Rw2FDyYyHFuNqZ9a4ilbCmfdxcGjoxs0kO+FlJ2pBoAFxMwMpQ6Xkf68zmbfzIyH
	IsYjdyVgJdjoXCErxHj
X-Received: by 2002:a17:902:d582:b0:2df:98b4:c294 with SMTP id d9443c01a7336-2df98b4cb7fmr28618195ad.61.1790421251744;
        Sat, 26 Sep 2026 04:14:11 -0700 (PDT)
Received: from localhost.localdomain ([104.28.254.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dfa60bfb1csm7247365ad.48.2026.09.26.04.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:14:10 -0700 (PDT)
From: Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 0/3] Add MT7629 TOPRGU reset support
Date: Sat, 26 Sep 2026 19:13:58 +0800
Message-Id: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ6CMBBA0auQWTsRq7bBqxgXbRlgEilkppgmh
 LtbXb7F/zsoCZPCo9lB6MPKS6q4nBqIk08jIffVYFpj285YDDecs7Omw7ysMm54jWEwzrsY7z3
 UbBUauPyXz1d18EoYxKc4/UZvTlvBRCWfZ6+ZBI7jC/yFE+yGAAAA
X-Change-ID: 20260926-b4-mt7629-toprgu-3cbf27a7cc5d
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
X-Mailer: b4 0.14.3

Define all seven subsystem reset IDs documented in the MT7629 TOPRGU
SWSYSRST register and expose the reset controller in mt7629.dtsi.

Add MT7629 watchdog match data to cover reset IDs through bit 12. The
MT6589 fallback only allows IDs 0 through 11, leaving the CONN_MCU
reset inaccessible.

---
Chuanhong Guo (3):
      dt-bindings: reset: mediatek: add MT7629 TOPRGU reset indices
      watchdog: mediatek: add MT7629 reset controller support
      ARM: dts: mediatek: expose the MT7629 TOPRGU reset controller

 arch/arm/boot/dts/mediatek/mt7629.dtsi    | 1 +
 drivers/watchdog/mtk_wdt.c                | 6 ++++++
 include/dt-bindings/reset/mt7629-resets.h | 9 +++++++++
 3 files changed, 16 insertions(+)
---
base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
change-id: 20260926-b4-mt7629-toprgu-3cbf27a7cc5d

Best regards,
-- 
Chuanhong Guo <gch981213@gmail.com>

