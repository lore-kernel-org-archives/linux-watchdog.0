Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802543CB576;
	Thu, 30 Jul 2026 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448827; cv=none; b=PoVu83E+4cfdWAl+Hdz5tYynZyza9gSmIffljIybp8t+JFUZTBXxyDpRwU8JVPGGHwyUdV7YuC4FjP9yHoMOF+puIYxGQUFRklS7Glz7+z3zpmXuXXFE97eJwbRYuxvMBXvcjLdjXnFgChhFlP7kNe2VVd/WMml1eAkbuVMum2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448827; c=relaxed/simple;
	bh=Wp0mqUPZWVkNcFglphCfVSwxnMXCbJkeE9ADnjkmes4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rEFbgEMe1+DHtWMLGYeTvA7585EnrQh1g+xq6S+7G7en/v3oW0xvJoSg2t03wtz0e8abdDBpkKmoNJ0Oid2ABJ0qkiFphocgmMoS1TiAvX3IoQma1hPTHlWmKA5gFhH/zQpVtHHejXESjZP0EW133+5NUEt34MjCvFUXoFe44hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwWEhhmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwWEhhmk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E94BC19425;
	Thu, 30 Jul 2026 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785448827;
	bh=Wp0mqUPZWVkNcFglphCfVSwxnMXCbJkeE9ADnjkmes4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FwWEhhmkqef1HMN/ycpom7x5o45Wg1qyKRgrKHllXl6JFev4gAORAFGgYHikt3NpR
	 yqdsdvLhthjp9xNcZjL5j3ym6LTjSHotNYP6XS83hLciq0TgIxXmJlZamw4wfA7xFg
	 XH9jqPPyljwUwyC/+dspeJJ9EOqGEskhUkLNsvJsbEUEOA2gUyfyeArgGivkuinSpE
	 4+PjpN7uNCTR+UzmHQp+EB4zY08FoAWoLgdNl/F+gx8XD03rSGSPEhtiEVMv6pOQ0w
	 INpHQgYc3/9ktoK9JCkPMSl42wLc5WygE9q7iVWMqLHXlsPiWmpyikn83pgvxGes4p
	 cXJ01da/ijwRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2EDC5516D;
	Thu, 30 Jul 2026 22:00:26 +0000 (UTC)
From: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>
Subject: [PATCH 0/2] watchdog: pretimeout: Allow building dump governor as
 module
Date: Thu, 30 Jul 2026 15:00:20 -0700
Message-Id: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHTJa2oC/x3MQQqAIBBA0avErBtIhayuEi3MphqCkrEikO6et
 HyL/xNEEqYIXZFA6ObIx56hygL86vaFkKds0JWuK6sbpCcccqIPF47Ob6c4T+gCR1SmnszYqNZ
 YC7kPQjM//7sf3vcDGP4jOWsAAAA=
X-Change-ID: 20260728-export-cpu-backtrace-apis-136d3b819377
To: Andrew Morton <akpm@linux-foundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, Mayank Rungta <mrungta@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785448826; l=1089;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=Wp0mqUPZWVkNcFglphCfVSwxnMXCbJkeE9ADnjkmes4=;
 b=/E/jAWOT7pmfUrBwiAzubVyp2fiDuSunmTZ/EOaZr5j5GFbLW0DexzdLukhaFeT4LArg80Gmx
 1G+T7Mx2MFFBy5sqoEhDO2z0B1pxBsGSBSFVHEsMhkKOYtVCUbcgqOw
X-Developer-Key: i=mrungta@google.com; a=ed25519;
 pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Endpoint-Received: by B4 Relay for mrungta@google.com/20260212 with
 auth_id=634
X-Original-From: Mayank Rungta <mrungta@google.com>
Reply-To: mrungta@google.com

All other watchdog pretimeout governors (noop, panic) can be built as
loadable modules. However the "dump" pretimeout governor is restricted
to built-in code because it calls trigger_all_cpu_backtrace(), which
relies on arch_trigger_cpumask_backtrace(), an arch specific helper that
is not exported to loadable modules.

This 2-patch series allows building the dump governor as a module (=m):
1) Export cpumask_backtrace() in lib/nmi_backtrace.c.
2) Convert CONFIG_WATCHDOG_PRETIMEOUT_GOV_DUMP from bool to tristate.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
Mayank Rungta (2):
      nmi: Export CPU backtrace APIs for loadable modules
      watchdog: pretimeout: Convert dump pretimeout governor to tristate

 drivers/watchdog/Kconfig |  4 ++--
 include/linux/nmi.h      | 10 ++++++----
 lib/nmi_backtrace.c      |  7 +++++++
 3 files changed, 15 insertions(+), 6 deletions(-)
---
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20260728-export-cpu-backtrace-apis-136d3b819377

Best regards,
-- 
Mayank Rungta <mrungta@google.com>


