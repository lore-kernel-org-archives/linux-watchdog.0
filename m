Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9D3B8922
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823371; cv=none; b=iRFMZwWKrq9NtqHMujnZuLl87kG/A8e1pBmjK4GQKOKzc5vPfrcpoW6E4qDsNElaYAfWmQdFFcUFWssbbVo744ef58dbSWp3J2UtyrmNuc2KDCDyQYcXsG3zVykXv1ApQQN0+uo3AcDKMfHtwXFobGcZ/fojRexUL8u/ezhh11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823371; c=relaxed/simple;
	bh=eAAR8QRYAU5FUSVKssILFt1d8jQIeSkpT5UQzrNNA4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShEtJfL6clF3Ejiy2o3oiyo8N7xY3Gj3lCF9bx4FJ69pvqVzuHsdV4IfNpTX36q2fmL2FAlM7bEKUHgUSKkkWPfdGOx+0xUH3GUG+BbMNVthyxQSxLh2Q2xHzwIxLeySGPTSEQspBDR2fNOqv547AM441jotGb4acWH+oWCpeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnUV4n3Z; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnUV4n3Z"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so7034561fa.1
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823355; x=1785428155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WF4Dbs6zRO0d71RsrP4HchYRm5rd3x9Pi7RivnUfa4=;
        b=PnUV4n3ZjPgXwvfA/iB0SYwzfhdZ3CzGFiIBm8oGGgiinJ7GyTc4ug6WG7USjcwq57
         wMQ+9aEDbhtXEC4NNFemw4jX7D6smXBVKEY/woD87KAIFs8qjwShNh6YnL6ZhBH4Dblb
         s9sA15bRtq3Tj0hlkAvKtw0GTZN1/AazLTARGuV50ungvPBptovE6tGtUYP2gTizs3mz
         aJ1UCmQJ7gSMs726fkgzhkG0UEZOSWmPkHW6KEuMUvtLcoSCzmxZHq6WJFp1f83KSVX6
         HI59u13xI2V4gSGNhqcoILOqvkAb+eKq++q4OpIWy9hoPV5jwjTdiVnYc9OdfFudVDsT
         1gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823355; x=1785428155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3WF4Dbs6zRO0d71RsrP4HchYRm5rd3x9Pi7RivnUfa4=;
        b=Q66vEOCx7gFzq/50UzhY9Ic7jnBFIefV4Tz+yOmOaKpb72OLqmrMIOC73MjgUYxkpy
         IMxaeTtUCK5R4A8cRujn7TxBXxQjgpZ2+c0nUIebvkSYEEvmkGRolY4IdyDyj0J86446
         4MdFSK93kZ0NDAHQnIC318mOb+i/OWPRGBX0uwLoIfvWgJq7+jnE40IlaY7d/u0D2hfP
         YNx84Misyif9PTtArjXf7SjoIJaEH1L1uaZUUUp1v72sFVI7GFNI+cOtKDj3ue29zQzw
         dz/002Cu9VPq1FkuA4iveFu/UEqknYKNtOEpJy+NCLok+TGYIUGpABjBaus4PX4EW19t
         TsUw==
X-Gm-Message-State: AOJu0Yx/4T2cQc2Rg6G7P1rWfor1bcfnSLkVv3GehNvl83iMK9YYscjR
	8e+9Of4Otaph8FhpfqhBRad8WfdnjOJC6wq+BDMbXMxSu1GYGoEKTBd37D8BLL+qHoY=
X-Gm-Gg: AR+sD10/KkVGueV+c0rPH9eHdBuMSkUEY6FWq84DwHj7VgByNnUt79ZfEQAw6L0fjD+
	w3JOk/B2erPYsJCJihdEUyh6TxqjclQ4IBdGdyANq+PqFJsjzFPP9W6zTctuMdRE1r77XGVfwCT
	K1M3lRWxrnGDTm4+9bWhI8yYXig+g6kShP6S/3RFhoChhSyNbkTlL2Y4ldVpQrBuuVig1cCVFFK
	8qbAaebkHA+RGZvRaiYOYySeN9wcxHsRtIMjaa++BukPdJJMDXkWoike1jP84RwIou/of45Ku8H
	IwRjwMMaPqm/0T9MdTAVK4upZgbL+xKdxo+nkkCCbndqiuTnVOtkxwGk3xRwbg2HQs/zssyOGNd
	qKLtqnp/tLZiOKJLWsRmrGpRJgiUsAA/vvsNpDuTdc69ioJ3KS9ehhm9JnfbbMln0l9QEN7SzqE
	NuveFhO9OGanx3g9g+vDsaTpPkDRzpN1KJYQK/XMGwG6/npfo76x0L7WKE/R6AqoB81D0peEl+A
	RvIQ3/YoZaRdFo=
X-Received: by 2002:a2e:a588:0:b0:39b:1b6d:5027 with SMTP id 38308e7fff4ca-39f07c70ba8mr7958461fa.11.1784823354940;
        Thu, 23 Jul 2026 09:15:54 -0700 (PDT)
Received: from localhost.localdomain (46-138-176-102.dynamic.spd-mgts.ru. [46.138.176.102])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6d8c40fsm9875561fa.41.2026.07.23.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:15:54 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: linux-watchdog@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	ojeda@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	dakr@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	lossin@kernel.org
Subject: [PATCH v2 2/3] rust: reboot: add emergency_restart() wrapper
Date: Thu, 23 Jul 2026 19:15:28 +0300
Message-ID: <20260723161529.23759-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723161529.23759-1-iprintercanon@gmail.com>
References: <20260723161529.23759-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a minimal reboot module wrapping emergency_restart(), which
restarts the machine immediately without syncing or unmounting
filesystems.

This is needed by watchdog drivers that must restart the system when
the watchdog expires, such as the Rust software watchdog added in a
subsequent patch. emergency_restart() is safe to call from any
context, including the interrupt context of an expiring timer.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/reboot.rs           | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)
 create mode 100644 rust/kernel/reboot.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e692d142c8608..89f0e1f65f6d7 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -81,6 +81,7 @@
 #include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/random.h>
+#include <linux/reboot.h>
 #include <linux/refcount.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a1130c4b82881..e603c07dc53dd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -113,6 +113,7 @@
 #[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
 pub mod pwm;
 pub mod rbtree;
+pub mod reboot;
 pub mod regulator;
 pub mod revocable;
 pub mod safety;
diff --git a/rust/kernel/reboot.rs b/rust/kernel/reboot.rs
new file mode 100644
index 0000000000000..f98a85d19f85d
--- /dev/null
+++ b/rust/kernel/reboot.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Reboot support.
+//!
+//! C header: [`include/linux/reboot.h`](srctree/include/linux/reboot.h).
+
+use crate::bindings;
+
+/// Restarts the machine immediately, without syncing or unmounting
+/// filesystems and without going through the reboot notifier chains.
+///
+/// This is intended for situations where the system is in a state where an
+/// orderly shutdown is no longer possible, for example when a watchdog
+/// expires. It can be called from any context, including interrupt context.
+pub fn emergency_restart() {
+    // SAFETY: `emergency_restart` has no preconditions and is documented as
+    // safe to call from any context.
+    unsafe { bindings::emergency_restart() }
+}
-- 
2.43.0

