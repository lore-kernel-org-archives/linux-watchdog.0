Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107235;
	b=Tnq4DqudRZDDvMK2i1QMjRZbGc1uv8Q8tKnLD9b1Z1dGFtt+h8VrrxncDgi9ZVwKFvqB
	 fLnjLkeIetnNQ8Rx+wqJT8vxGH+xAa9B72M3/Ev6oJXstPjPcvEMEBNnvKlkgQe6e/iQ4
	 bzAJSRLs8lwHNNDir1zXfuLxGC2mYy9WgmXoQH9rrAtFDCnnM+avMwjpG9R5yLjSma4dP
	 WkUnW4rma/f+ngDnyECZTfW9VTaJCSQ/AgM3sfwCABgGZHSrlvMReBKpZgwQ5ywcLlSKm
	 h0ga8Yxrc4+TDymt4g8jIY6ZU9mwTQNp72JmtNWE2qSq8w9mecjOmUrDkvAK2lBzNzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107235;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uLq55cpvB+Q365G9MISzGTDd2mLVrHcfdN0AU9A81Mg=;
	b=UtdJtrNDWyQd6HZfUZlPXNb6vu2ymwDyQd6wRpgIIdwHbdtnr1t+5mFe+XF3VMOV33hJ
	 K9nQxuDLdkfhnA1jc0AOLsJrueMKuceGZiG9WGm5bLDx5VD7tY9Vp8YirQPCxs0Ee79xV
	 GRmqTT66ljQMFdOVGW2z/gKsmHpn4EDRtNUy8jQGAeapJbqdphA43P8dxgXz4HYH3GmG6
	 wBp4zWLnA3mnQSMaqQsAbkn6eGGz+o7NuaEAZuVwNarr60z7S+7WCJ3QOlDmLMpwNorQd
	 3CN01BUVRcdOT3AopQIMAkAPNkD0f/Y3yz+I/Cgy+UYmTwk19ifux2bE81Md6k+O7VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i47GHb/X";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148D606A32F;
	Thu, 19 Nov 2026 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i47GHb/X
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795107235;
	b=PEcF3gOz2+nHbDzNtGw0yfNU5PZLEwyqLtDGDqRtq3acZPsluuPNMQNjpljmihdAdzHN
	 z79OhfHLgGksTxAqCDBfyY+ku3Olffc7NxFxl1hPOlNTHzofKyvzmtFkzudCz9m6t5lmn
	 FPT7pWNy9Pypm2iAsKO9KnVIB4E+pmOvx98+NfHQll+lLBxsBPY/3ZN+Y0trgZ3LwNOSm
	 0anpR+XIp14UBS3o8ql+rNx4BSE69yH4H1srD1r3h3vUddMdx5/MUdSnSuc3ZX/QLKGbQ
	 hlxfT3BHyju6Mm5mRCaUvVVBXgkEjcxeIAeHBO/oLaSWXGtpakxLMJZtJBiIyX+CMww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107235;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uLq55cpvB+Q365G9MISzGTDd2mLVrHcfdN0AU9A81Mg=;
	b=eWuSe2tK+tVa0lV/5QMJXTR0M36brtenElRiWz8roeOtNWEneFVvebtMYLUDENfKyG99
	 v4xV8L+A902khsCde9m77DPg5HK5uBJuArlMrTtoJZvsHXDBD8J8wloy2ihX9bpwCf0vE
	 /rWfNh+L6NqSfRIgMVaWQoVPBKeBOS6EsGrgBzbu8fRlEOzZFkaQNTJ/yHZbXoKox3b2Q
	 sXVDFO/g5BX+OmownwYWp8Kxz0J/3EQIkS/l/hxD8dMLxpwKwoswEhR87SpC7l4qF3hHe
	 nu6Pw3r147/n/7gUnc/fuD8tnzAoa/hSoJCrQpXS8D3LXlkybB+B91PAEIPGXoW5i1A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 83E021F000CC;
	Thu, 19 Nov 2026 16:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795107234;
	bh=uLq55cpvB+Q365G9MISzGTDd2mLVrHcfdN0AU9A81Mg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=i47GHb/XxRTEhT6f3virlp3OhhN6ND7l3j49L3rivpsTNYshEFAkzJMNkvTpdCXdU
	 OWju5q4TGRe6QhSuH0nw/fwI8bgjUmojEEvcK0C9pLIaKjWiHojMBYxc9K8wwMjTho
	 tRfPgBwmSlcim1elnn81IK3828V2I9YxbFjfAiHzAaV1wKqdg1js9NcN2USVTKF/P2
	 AyVv5ABsPZ0Oc0GJclvCmsA840momz9zUFgEnzHJ4RGOaT0ucUEe0lDuajo7H49Fnf
	 f0u/ZOlGyTpkDVDRMlcV4Sv2R0FW+wdTd3qHhrvdV1B6nDQ+8YbiyCYIdZ4xWFlUxu
	 GP/4X3pbPOLMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D88134B356;
	Thu, 19 Nov 2026 16:53:53 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 16:53:54 +0000
Subject: [PATCH RFC] watchdog: core: Ignore userspace keepalives once the
 system goes down
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-watchdog-reboot-keepalive-v1-1-c5902d959796@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMTQrCMBQGr1Le2kATVKpbwQN0K13k50v7VJqSp
 FUovbtRlzMws1JCZCQ6VytFLJw4jAXkriI76LGHYFeYVK2OUsqTeOlsBxd6EWFCyOIBTPrJC4R
 3h9rvTaMar6j0U4Tn9+99o/Z6oe4v02zusPl7pW37AN59C/iCAAAA
X-Change-ID: 20261119-watchdog-reboot-keepalive-fd50f4b828f2
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795107233; l=1792;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=8odbgLzkMjv4qHTEHWFN4RAGFDasNozQ665DspbA17w=;
 b=1rDr9Uz/tDZ9di0LWUyCicF5QfSmb3YYmZIPw4SQUeYUDtf+J6cTiSsiEf2uwfyQtfnpUzVjo
 kKRuVAQfoJECTRQvVUUMYLnkWlYJk1Ac3hTcM96ZL/kyMbrmU3CxEhn
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A watchdog left running through a reboot should reset a system whose
reboot hangs. But a daemon still pinging after reboot(2), such as
systemd after "systemctl reboot -ff", keeps a hang in device_shutdown()
from ever being reset.

Ignore userspace keepalives once system_state is past SYSTEM_RUNNING,
as da9062_wdt and da9063_wdt do since commit 2f61b3a74699 ("watchdog:
da9062: da9063: prevent pings ahead of machine reset").

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
RFC: this changes every driver. A reboot or power-off whose
device_shutdown() outlasts the timeout now ends in a watchdog reset.

Tested on an Orange Pi Zero2 (H616, sunxi_wdt) on 7.3.5 with a test
module that oopses holding a device lock: "systemctl reboot -ff" was
reset after 14 s in 6 of 6 runs. Without the patch there was no reset
within 90 s (one run, older 7.3 build). Other drivers and kexec are
not tested.

Developed with Claude (Anthropic) as a coding assistant, which wrote
the code and the commit message. I reviewed and tested it.
---
 drivers/watchdog/watchdog_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index aad3f1f1b4ce..0f149da49a69 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -201,6 +201,9 @@ static int watchdog_ping(struct watchdog_device *wdd)
 	if (!watchdog_hw_running(wdd))
 		return 0;
 
+	if (system_state > SYSTEM_RUNNING)
+		return 0;
+
 	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
 
 	wd_data->last_keepalive = ktime_get();

---
base-commit: 865c2d0f1dd3f0937865dd11819eeb59298a814c
change-id: 20261119-watchdog-reboot-keepalive-fd50f4b828f2

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


