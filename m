Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFBC3502B5;
	Mon, 23 Feb 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841114; cv=none; b=PxpWNH9NBuimRW090ayVJE3qZ2vXIUVZ2h/8wgaZuz4A23DlSLUpQNWxVJ4djVmcm3TANTbVDz/D5zNahe7gLzj6reIZkAAmGw50yuU3yHX0CgRV8AeLNhgixSM0zgj9DrR4tZX75hXYmqmLgcjygzYpgpiOrkf58joGDOuVW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841114; c=relaxed/simple;
	bh=CwOK2TpwDjvleWI5ncKbppOyRNpTmchpH8bwQirbQvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXvZRE98NtCUM6W868xb6mzYfm39Q0+JtgGIDK84eIv+gFvftXckKSGCjCc31X8xr/fuMPWr2L1QQ3i34Hrsf6Q7FUmLgJEN3SIp8q8ZOSefpOBmBl+CEk44bwG7TvOFgz3AhDXQN7SBv1o3U6O+/mj+mDnW3AS0rAYlDCYirpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKPagN2y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKPagN2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92C6C116C6;
	Mon, 23 Feb 2026 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771841114;
	bh=CwOK2TpwDjvleWI5ncKbppOyRNpTmchpH8bwQirbQvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKPagN2y9Kwouaty5QIPa7gZFwDoAlsoo0xyF19YB/v4b+xeGOgXtoUDiKjBA9K7N
	 h06h1VPb3PjfJ6OiUA2lIjm8AEQDhUPI84st2zmiQ2V2/o/lW58A8KkjxWBTNPsl/d
	 sYXiPSLWNkj8LaANH2S4GJcJBJtJ2dazTPvMznKJoCjXCVubiHAondwz6QkCu9H3Is
	 fxKDxIj3snY/6vqWBcsNk3067zbDriWTI4dD4cmNiTCoGO7nerKkG9KoaTFy5OpXM/
	 NguJkNLhn2s99I/TOzithQCIHNz+N1jPceI6qRrZJx+89jQW6IyZ4+fmHrzClFOZnn
	 Ka24jO5gRy4nw==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Srinivas Kandagatla <srini@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/8] arm64: defconfig: remove SENSORS_SA67MCU
Date: Mon, 23 Feb 2026 11:04:47 +0100
Message-ID: <20260223100459.844967-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223100459.844967-1-mwalle@kernel.org>
References: <20260223100459.844967-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the SENSORS_SA67MCU from the defconfig because the driver will be
removed.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b67d5b1fc45b..b7bdb8af77b4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -754,7 +754,6 @@ CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
-CONFIG_SENSORS_SA67MCU=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
-- 
2.47.3

