Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EBB44A3E9;
	Tue, 18 Aug 2026 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076210; cv=none; b=tDy40sDNpNBOHHL+m5xSY3ZKeaZiug6+aCoMqQdlxr8zPciWsg7UGhBN3UaeTQQxx0ksahrlD5x/y9lkZKn6vSkmvF0baMmP0GydpgRNbpxFgkc/WeyyQ06ZzhmZab+L8JeTLfzbnVQHYaDASupZz9/pf1fdO9KLDN4EQBkS1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076210; c=relaxed/simple;
	bh=8HrdoPzCe8M0K/kkdyBGtCSmfZLfdSCynj06k0MN/yw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=orwZKdz7W4YJOg2hHNOcpY3rXobOgYhLWey+WaQAMk/jXRV74oJCeKBUd/Kd4ADS8/b7V21lX0oboPeDOHKAhrTDWZigi0/DZr9kRZRH8xeIVaQpMbl1Zuyuu0AhJ/N5fdsHinBRU2UuTaqaTS6mPu291FZ0eR07fn53KNjTCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDrV96yL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDrV96yL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12606C19425;
	Tue, 18 Aug 2026 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787076210;
	bh=8HrdoPzCe8M0K/kkdyBGtCSmfZLfdSCynj06k0MN/yw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bDrV96yLOsjewhV0h5DUWnTFMxM6j0kWlaPI4v966JosL7kdaB2pG7AtWQlgdZFS1
	 yn4GWsYUfIxzF0ipwI/K0F3JXX61kUl+z0I5CUyqb+AcHDKyaP1VNn7uUj9dg2d78b
	 UoVmKLnq5ca6wN592PDCj9Ksf7d3mAo4ghmU/mkpacHKboDhdjG1oLR3ak1Dqt2vdi
	 aHFje6FnKBxam5B/SRRBXZd008L5v5S1Qh+Sv/88tV4XQFNYqT/W2hGdQR0/rct5ki
	 yMcrhuwRFIjD56FspzF12TZvmC5RTmx7PnkaSVyUV0SreXQAWFl3nPZT6J1Wmr4avX
	 r2t5rpyx3wzqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6521C5DF7D;
	Tue, 18 Aug 2026 18:03:29 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Subject: [PATCH v3 0/2] watchdog: Add Exynos5515 watchdog timer support
Date: Tue, 18 Aug 2026 19:03:16 +0100
Message-Id: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSehGoC/32N0Q6CIBhGX6VxHQ4QRbvqPVoXgj9KpTRA0znfP
 bW1tbW6PNv3nTMhD86AR4fdhBz0xhvbLhDvd0jVRVsBNuXCiBGWkowmWFuHWxgCvnXqOgr8KIK
 qS1vhmEktE0pzqila7ncH2gyb+nR+se/kBVRYfeuiNj5YN27tnq67d0b8zvQUE1xQHgsCjMicH
 RtoJLhIex1ZV6G11bNPW/bHxhZbKnisucgLLvSXbZ7nJw9BaFMlAQAA
X-Change-ID: 20260815-for-next-lucky7-watchdog-32bfb51191f1
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Aiden Isik <aidenisik@member.fsf.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2292;
 i=aidenisik@member.fsf.org; h=from:subject:message-id;
 bh=8HrdoPzCe8M0K/kkdyBGtCSmfZLfdSCynj06k0MN/yw=;
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqhJ5qDXxwECM3vqTnOkqyEwFfgqeEcIY8Lz5Sj
 56zeQpl9qCJAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaoSeagAKCRBJJwGyxHrX
 68wvD/9K1UE+6Xx6yiiz86LOMAbT+nK3nUF/FmuEjTVEGPmFsGz6WBfnSESJynM+wMcaSNXWb+l
 ChR1ItFfgjaQDUvWbfCUOOkW9oa4HWP0fUyavot8vudQKuDLus8VmmBobrEZO+03EWupLL9XYmv
 n+AqpBStCIhoPd5sVk+jux1ygvVr9wc9Va4fHZo/eY/m3Wb0nphLrw2k+zY8AD8vZCC4h8XV3r2
 YLJ5ki91OM+QGc66+XJ7p+oOkIdrxcZbQIwtINxqRB7GNmo6Ln4PDwfPRlOBN4Ds9juSnICJ3oB
 DVdRoY7OGMfQOInzH9SxxRD6SwgF5dwSEXbU6Kp7vi0ojku8wU6JYAtjVd58612lAmuqCv96UKW
 2nfTbPJFSoip6kjdQLKOaG+2xZlrYJKHNfrzLJ8053QFslU3/GHosv5Oe55m9nrmnafnMvWPHYN
 sLywFDRZS7MaTzTcJIzbFthUI5rqmfr9uuLJLKICA2OujHI1/n22aZ0RezKnfyeaLRfmdrbzEkf
 llMbpgbp/cnwxEOOUwx7kLoI1iGpkVdrO7x4DBi3BsCsC3uNnhPWMU3kwLiHn9/LcT+5VPhKqrf
 ltyG9zTWBdzoknvWDZFud1plPQhCDn8QcsMbZKP6y287LbkNiZQ2embLt7+Z4l/vxTuGbDDmc2E
 5nY1gdjXB9wKNZA==
X-Developer-Key: i=aidenisik@member.fsf.org; a=openpgp;
 fpr=83CBC5245C6A5CDC935B11A5492701B2C47AD7EB
X-Endpoint-Received: by B4 Relay for aidenisik@member.fsf.org/default with
 auth_id=956
X-Original-From: Aiden Isik <aidenisik@member.fsf.org>
Reply-To: aidenisik@member.fsf.org

Hi there,

This patchset adds support for the Exynos5515 SoC's watchdog timer
to the S3C2410 watchdog timer driver.

There is one checkpatch warning for this patchset:

> -------------------------------------------------------------------------
> Commit 8f4ec3a9b89b ("watchdog: s3c2410_wdt: Add exynos5515-wdt compatibl
> -------------------------------------------------------------------------
> WARNING: Avoid unnecessary line continuations
> #26: FILE: drivers/watchdog/s3c2410_wdt.c:240:
> +       .quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \

Which seems to be erroneous: this line continuation is necessary
(and is done by every other existing entry).

Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
---
Changes in v3:
- Set reset_mask_inv to true
- Remove erroneous QUIRK_HAS_PMU_AUTO_DISABLE flag
- Link to v2: https://patch.msgid.link/20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org

Changes in v2:
- Add samsung,cluster-index: false to documentation
- Remove SoC comment from documentation
- Correct signed-off-by tag in commits
- Link to v1: https://patch.msgid.link/20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org

To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org

---
Aiden Isik (2):
      dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible
      watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data

 .../devicetree/bindings/watchdog/samsung-wdt.yaml  | 23 +++++++++++++++++++++-
 drivers/watchdog/s3c2410_wdt.c                     | 12 +++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
---
base-commit: acde40ba506aae78633e080b5704d33cf4bc13c6
change-id: 20260815-for-next-lucky7-watchdog-32bfb51191f1

Best regards,
--  
Aiden Isik <aidenisik@member.fsf.org>


