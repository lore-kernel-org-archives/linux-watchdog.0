Return-path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Michal Marek <mmarek@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>, Pedro Alves <palves@redhat.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Chris J Arges <chris.j.arges@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 27/33] watchdog/hpwdt: Create stack frame in asminline_call()
Date: Thu, 21 Jan 2016 16:49:31 -0600
Message-Id: <60de3cfb6f16d413bfb923036cc87fec132df735.1453405861.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1453405861.git.jpoimboe@redhat.com>
References: <cover.1453405861.git.jpoimboe@redhat.com>
List-ID: <linux-watchdog@vger.kernel.org>

asminline_call() is a callable non-leaf function which doesn't honor
CONFIG_FRAME_POINTER, which can result in bad stack traces.

Create a stack frame when CONFIG_FRAME_POINTER is enabled.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/hpwdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 286369d..f368383 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -353,10 +353,10 @@ static int detect_cru_service(void)
 
 asm(".text                      \n\t"
     ".align 4                   \n\t"
-    ".globl asminline_call	\n"
+    ".globl asminline_call	\n\t"
+    ".type asminline_call, @function \n\t"
     "asminline_call:            \n\t"
-    "pushq      %rbp            \n\t"
-    "movq       %rsp, %rbp      \n\t"
+    FRAME_BEGIN
     "pushq      %rax            \n\t"
     "pushq      %rbx            \n\t"
     "pushq      %rdx            \n\t"
@@ -386,7 +386,7 @@ asm(".text                      \n\t"
     "popq       %rdx            \n\t"
     "popq       %rbx            \n\t"
     "popq       %rax            \n\t"
-    "leave                      \n\t"
+    FRAME_END
     "ret                        \n\t"
     ".previous");
 
-- 
2.4.3
