Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCCB4CA272;
	Fri, 21 Aug 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325306; cv=none; b=CPzR4ajP/cjtvlUzkgu1OpJ+bqTtG/JbiUDfpngEoC0Og+Dye5VYdPO/qp/XAwJcjKGlcDUuwKPKmZvEvup85ZLL3kM7ZrrifUyTAduE0/PAbo1eYFapaej0KmKxHEasAQaLb/AhltfmisxJFNuQxQfHizerMID7InZRb7J5dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325306; c=relaxed/simple;
	bh=VXHO+kNVkIWlKDiPQc9CV6EV7wZW3VHxCByk4YJuSVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JWEcvF3SS6CB/Wf+xeqGrB4VZEDOhGNQgEa0r3juVgGL0OBwUcEI/aTpOkMzW1zU0sBlAuaugbU0St6sDs+P0WhnOb0k/V/cARnk50Ghw6Q/7xFHT3+q0pWv6d2dZTaqk7Wca98/M8hyex22fM/0mUsXyrvc4btB/2vYEoOcvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibY4Lrid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibY4Lrid"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDD8EC19425;
	Fri, 21 Aug 2026 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787325305;
	bh=VXHO+kNVkIWlKDiPQc9CV6EV7wZW3VHxCByk4YJuSVE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ibY4LridY8uHHYLEuMR8zOzkZEryBWYRxT9BdIjdn7hO4CoHVJYRQ3XV35y5RQY3E
	 K3cum1YpCe0BoHCl2X9EBM9nhjs1M0tLEpa+Mvew3f243gJ0NcbsSeoGLNTL0uqJfo
	 KMrGm+XmmwyfF21eWf7ot6D8DEEmzFJzvuAqvY7uDHN3PV272aI+UjIMwKH0k9Nr2R
	 WUpTNSHzHg0GMwSxw7J6+Fme/drLgPKwsNRTr+3hgNuMDVZk6vOTkwHxmdd+SHdGRg
	 Ye9CYpBR4uIxuLeALjihIaF+yR+liLUWbCzTBmBoWW/RyUNhAWddehF2pSFOMebxl9
	 kW2eZ1+0p9A4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A84EC5DF7D;
	Fri, 21 Aug 2026 15:15:05 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Subject: [PATCH v4 0/2] watchdog: Add Exynos5515 watchdog timer support
Date: Fri, 21 Aug 2026 16:14:48 +0100
Message-Id: <20260821-for-next-lucky7-watchdog-v4-0-d070cee5009f@member.fsf.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGhriGoC/43NQW7CMBCF4asgr2vkGTuYsOIeVRexM04MTYzsk
 IJQ7l4HhIQEVF0+aeb7LyxR9JTYZnFhkUaffOjzUB8LZtuqb4j7Om+GAldiDQV3IfKeTgP/Ptr
 9WfOfarBtHRou0ThTAJTggOX3QyTnT1f68+u209HsyA6zN1+0Pg0hnq/tEea7e0a/z4zABa9AS
 S0IhSlx21FnKC5dcssQGza3RnzU1n9omLWVVtIpXVZKu5ea/K8ms4YloKkB0Rb6SZum6Rd1SSA
 BcwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2502;
 i=aidenisik@member.fsf.org; h=from:subject:message-id;
 bh=VXHO+kNVkIWlKDiPQc9CV6EV7wZW3VHxCByk4YJuSVE=;
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqiGt2Ym2mQo0hLEJozDIpiyFLoV2A+s24KQJG7
 /+aXxtP3yKJAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaohrdgAKCRBJJwGyxHrX
 68QlEACmUAm8BTspIEJiODwEY25xCo/2ftYOf0zubcOQ7XZNtrcU8TNma0wDhfZymhlSqvEg9tP
 n5W6p4HSzP/AFFGrH5qFHjX4rPJ/D6PbhJDi8X0o42Ba7kod6j4F52h4OMC+Z5tHv+KAZXmoj1V
 BInREaFbLcBBnCONOD3O2IrcybsuRwX5OOyUFWqWCC+Ky/j4rjiD5DaVz3ivMB/FRrfJt7n0wUK
 mzoIPd8XNx3wO0n5kjRLof/KUqzV2N9ZAxeZyaO8C5pgrlq7lOyJ6BiyaTw3DNyRd1Pa5VmBX7t
 Al4XIn6sdwp1U1K7kszVQk0qKjBKE5+wpWsolkjS1TffoMmzm+SDfife3q2VjwwIuQfXBg8RnO8
 ZNy7icCPY2dnyFPOkFTI696Gedq8lN1t2vCjXKB6mbYfoccO6gbdr+h/PHDnfQ5E7gEz6MISmpT
 BlJyqZBHFkSb931MYo67tHwFElofHMqxA0KYeZK3WA6nU6hmQaVv8MR9dvEoWM/d09Q2DYT9WIw
 whgN6San0815htjMQrGxSJJmzWqveE4fScKuVB4jWXFCImj8vOA+trTEYPuoEOFdjqxqy9hiTaG
 yqpXwZDsHo+3/3pU5zPCykqyKSeuxQzJksmTaqfYkRxrUpne7xL00WwtwShEryfwWny4obOwHe5
 rHTizop89X9NS7g==
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
Changes in v4:
- Add comment and commit message explaining why QUIRK_HAS_PMU_CNT_EN is not set
- Link to v3: https://patch.msgid.link/20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org

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
 drivers/watchdog/s3c2410_wdt.c                     | 16 +++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)
---
base-commit: acde40ba506aae78633e080b5704d33cf4bc13c6
change-id: 20260815-for-next-lucky7-watchdog-32bfb51191f1

Best regards,
--  
Aiden Isik <aidenisik@member.fsf.org>


